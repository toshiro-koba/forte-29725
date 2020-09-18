class CreateGameTags < ActiveRecord::Migration[6.0]
  def change
    create_table :game_tags do |t|
      t.string :game_title, null: false
      t.timestamps
    end
  end
end
