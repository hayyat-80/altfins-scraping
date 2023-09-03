class CreateTradeIdeas < ActiveRecord::Migration[7.0]
  def change
    create_table :trade_ideas do |t|
      t.references :user, null: false, foreign_key: true
      t.references :currency_pair, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.string :rating
      t.string :image

      t.timestamps
    end
  end
end
