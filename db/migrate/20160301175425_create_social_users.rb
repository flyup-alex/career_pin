class CreateSocialUsers < ActiveRecord::Migration
  def change
    create_table :social_users do |t|
      t.string :facebook_token
      t.string :twitter_token
      t.string :twitter_secret
      t.string :facebook_uid
      t.string :twitter_uid
      t.string :social_uid

      t.timestamps null: false
    end
  end
end
