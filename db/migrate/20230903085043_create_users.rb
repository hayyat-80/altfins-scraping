class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :roleType
      t.string :status
      t.string :profileImage
      t.string :accessToken
      t.string :password

      t.timestamps
    end
  end
end
