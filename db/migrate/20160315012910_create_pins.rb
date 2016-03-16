class CreatePins < ActiveRecord::Migration
  def change
    create_table :pins do |t|
      t.string :author_image
      t.string :link
      t.string :provider
      t.string :image
      t.string :author_name
      t.text :message
      t.datetime :creation_time
      t.string :company_name
      t.integer :social_user_id
      t.integer :company_id
      t.boolean :career_pin, default: false
      t.timestamps null: false
    end
  end
end
