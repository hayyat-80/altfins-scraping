class CreateTechnicalAnalyses < ActiveRecord::Migration[7.0]
  def change
    create_table :technical_analyses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :currency_pair, null: false, foreign_key: true
      t.string :trade_setup
      t.string :trend
      t.string :pattern
      t.string :momentum
      t.string :support_resistance
      t.string :image

      t.timestamps
    end
  end
end
