require 'selenium-webdriver'
require 'down'
require 'aws-sdk-s3'

class FetchDataService
  def self.fetch_data
    login_url = 'https://altfins.com/login'
    url = 'https://altfins.com/technical-analysis'
    
    Webdrivers::Chromedriver.required_version = ENV['DRIVER_VERSION']
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    driver = Selenium::WebDriver.for :chrome, options: options

    driver.get(login_url)
    sleep 10
    username_field = driver.find_element(id: 'vaadinLoginUsername')
    password_field = driver.find_element(id: 'vaadinLoginPassword')

    username = ENV['ALTFINS_USERNAME']
    password = ENV['ALTFINS_PASSWORD']

    driver.execute_script("arguments[0].value = arguments[1];", username_field, username)
    driver.execute_script("arguments[0].value = arguments[1];", password_field, password)

    login_button = driver.find_element(css: 'vaadin-button[part="vaadin-login-submit"]')
    driver.execute_script("arguments[0].click();", login_button)

    driver.get(url)
    sleep 10
    page_count = driver.find_elements(css: 'div.paginator-wrapper')[1].find_elements(tag_name: 'span')[1].text.match(/\d+/)[0].to_i
    data = []
    page_count.times do |i|
      puts "page no #{i+1}"
      input_element = driver.find_element(css: 'input[slot="input"][type="text"][title="60 items"]')
      driver.execute_script("arguments[0].value = arguments[1];", input_element, i+1)
      # Trigger the Enter key press event using JavaScript
      driver.execute_script("arguments[0].dispatchEvent(new Event('keydown', {bubbles: true, cancelable: true, keyCode: 13}));", input_element)
      sleep 5

      grid = driver.find_element(tag_name: 'vaadin-grid')
      # data = grid.text.split("\n")
      # pairs = data.each_slice(7).to_a
      content = grid.find_elements(tag_name: 'vaadin-grid-cell-content')
      sub_data = []
      date_pattern = /\b(?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) \d{1,2}, \d{4}\b/
      content.each_with_index do |c, i|
        if c.text.match?(date_pattern)
          data << sub_data
          sub_data = []
          sub_data << c.text
        elsif c.text == 'inspect'
          driver.execute_script("arguments[0].click();", c)
          sleep 10
          driver.execute_script("arguments[0].scrollIntoView(true);", c)
          cell_no = c.attribute('slot').match(/\d+/)[0].to_i + 4
          inspected_cell = grid.find_element(css: "vaadin-grid-cell-content[slot='vaadin-grid-cell-content-#{cell_no}']")
          image_url = inspected_cell.find_element(css: 'img.fullscreen-image').attribute('src')
          sub_data << { desp: inspected_cell.text, img_src: image_url }
        else
          sub_data << c.text
        end
      end
    end
    data = data.reject {|subarray| subarray == ["Updated Date", "Asset Symbol", "Asset Name", "Chart View", "Near Term Outlook", "Pattern Type", "Pattern Stage", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""]}
    data.each do |d|
      record = TechnicalAnalysisRecord.where(update_date: d[0], asset_name: d[2])
      unless record.present?
        record = TechnicalAnalysisRecord.new
        record.update_date = d[0]
        record.asset_symbol = d[1]
        record.asset_name = d[2]
        record.description = d[3][:desp]
        record.image_src = upload_to_s3(d[3][:img_src])
        record.near_term_outlook = d[4]
        record.pattern_type = d[5]
        record.patter_stage = d[7]
        record.save
      end
    end
  end

  def self.upload_to_s3(image_url)
    s3_client = Aws::S3::Resource.new(
      access_key_id: ENV['S3_ACCESS_KEY_ID'],
      secret_access_key: ENV['S3_SECRET_ACCESS_KEY'],
      region: ENV['S3_REGION']
    )

    image_data = Down.download(image_url)

    obj = s3_client.bucket(ENV['S3_BUCKET']).object("images/#{SecureRandom.uuid}.jpg")
    obj.upload_file(image_data.path, acl: 'public-read')

    obj.public_url
  rescue StandardError
    image_url
  end
end

