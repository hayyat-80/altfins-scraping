class CreateTechnicalAnalysisRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :technical_analysis_records do |t|
      t.string :update_date
      t.string :asset_symbol
      t.string :asset_name
      t.text :description
      t.string :image_src
      t.string :near_term_outlook
      t.string :pattern_type
      t.string :patter_stage

      t.timestamps
    end
  end
end
