class RoomMessage
  include ActiveModel::Model
  attr_accessor :question_title, :user_ids, :game_tag_ids, :content, :user_id, :room_id

  validates :question_title, presence: { message: '質問のタイトルを入力してね！'}
  validates :user_ids, user_check: true
  validates :game_tag_ids, game_tag_check: true
  validates :content, presence: { message: 'メッセージを入力してね！'}

  def save
    room = Room.create(question_title: question_title, user_ids: user_ids, game_tag_ids: game_tag_ids)
    Message.create(content: content, room_id: room.id, user_id: user_id)
  end
end
