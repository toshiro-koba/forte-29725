class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string  :link_to_sns
      t.string  :link_to_webcast
      t.text :self_introduction
      t.string :image
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
