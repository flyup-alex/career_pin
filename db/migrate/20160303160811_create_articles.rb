class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :company_name
      t.string :facebook_uid
      t.string :twitter_uid
      t.string :name
      t.string :provider
      t.text :text
      t.datetime :time
      t.string :photo_url
      t.string :link
      t.string :author

      t.timestamps null: false
    end
  end
end
