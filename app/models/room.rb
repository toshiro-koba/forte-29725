class Room < ApplicationRecord
  has_many :entries
  has_many :users, through: :entries
  has_many :messages
  has_many :room_game_tags
  has_many :game_tags, through: :room_game_tags

  validates :question_title, presence: {message: '質問のタイトルを入力してね！'}
  validates :user_ids, length: { minimum: 2, message: "回答して欲しい人を選択してね！" }
  validates :game_tag_ids, presence: {message: 'ゲームタイトルを選択してね！'}



  def self.search(search)
    if search != ''
      Room.where('question_title LIKE(?)', "%#{search}%")
    else
      Room.all
    end
  end
end
