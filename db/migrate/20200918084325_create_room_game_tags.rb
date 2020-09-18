class CreateRoomGameTags < ActiveRecord::Migration[6.0]
  def change
    create_table :room_game_tags do |t|
      t.references :room, foreign_key: true
      t.references :game_tag, foreign_key: true
      t.timestamps
    end
  end
end
