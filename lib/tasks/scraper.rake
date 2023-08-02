namespace :scraper do
  desc "Run Data fetching"
  task run_fetching: :environment do
    FetchDataService.fetch_data
  end
end
