class CreateStalkedPages < ActiveRecord::Migration
  def change
    create_table :stalked_pages do |t|
      t.string :name
      t.string :image_url
      t.string :pageid
      t.integer :company_id
      t.string :provider

      t.timestamps null: false
    end
  end
end
