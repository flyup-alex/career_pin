class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.integer :views
      t.integer :visited
      t.integer :company_id
      t.string :special_user_statistic_key
      t.integer :company_name
      t.boolean :career_pin, default: false

      t.timestamps null: false
    end
  end
end
