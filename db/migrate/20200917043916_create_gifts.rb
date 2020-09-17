class CreateGifts < ActiveRecord::Migration[6.0]
  def change
    create_table :gifts do |t|
      t.references :user,  foreign_key: true
      t.references :giver, foreign_key: { to_table: :users }
      t.integer :price,    null: false
      t.timestamps
    end
  end
end
