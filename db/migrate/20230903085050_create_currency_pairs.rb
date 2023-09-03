class CreateCurrencyPairs < ActiveRecord::Migration[7.0]
  def change
    create_table :currency_pairs do |t|
      t.string :label
      t.string :symbol
      t.string :image

      t.timestamps
    end
  end
end
