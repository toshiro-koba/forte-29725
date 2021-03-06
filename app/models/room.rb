class Room < ApplicationRecord
  # 質問に関するアソシエーション
  has_many :entries
  has_many :users, through: :entries, dependent: :destroy
  has_many :messages, dependent: :destroy
  # ゲームタグに関するアソシエーション
  has_many :room_game_tags
  has_many :game_tags, through: :room_game_tags, dependent: :destroy
  # いいねに関するアソシエーション
  has_many :likes
  has_many :likers, through: :likes, source: :user, dependent: :destroy
  # 通知に関するアソシエーション
  has_many :notifications, dependent: :destroy

  validates :question_title, presence: true

  # 質問一覧表示
  def self.questions(current_user, rooms)
    @rooms = rooms
    @questions = []
    temporary_questions = Entry.where(user_id: current_user.id).order('created_at DESC')
    temporary_questions.preload(room: [:likes, :game_tags, messages: :user]).each do |entry|
      @questions << entry.room
    end
    @questions
  end

  def self.other_questions
    other_questions = []
    temporary_other_questions = @rooms - @questions
    temporary_other_questions.each do |room|
      other_questions << room if room.messages.size == 2
    end
    other_questions
  end

  # 質問検索
  def self.search(current_user, search)
    @search_questions = []
    @rooms = if search != ''
               Room.where('question_title LIKE(?)', "%#{search}%")
             else
               Room.all
             end
    @rooms.each do |room|
      @search_questions << room if room.user_ids.include?(current_user.id)
    end
    @search_questions
  end

  def self.search_other_questions
    other_questions = []
    temporary_other_questions = @rooms - @search_questions
    temporary_other_questions.each do |room|
      other_questions << room if room.messages.size == 2
    end
    other_questions
  end

  # ユーザー詳細ページにおける、質問一覧表示
  def self.user_questions(user, _rooms)
    questions = []
    @user_other_questions = []
    temporary_questions = Entry.preload(room: [:likes, :game_tags, messages: :user]).where(user_id: user.id).order('created_at DESC')
    temporary_questions.each do |entry|
      questions << entry.room if entry.room.messages.size == 2 && entry.room.messages[1].user == user
      @user_other_questions << entry.room if entry.room.messages[0].user == user
    end
    questions
  end

  class << self
    attr_reader :user_other_questions
  end

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  def create_notification_like!(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(['visitor_id = ? and visited_id = ? and room_id = ? and action = ? ', current_user.id, users[1].id, id, 'like'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      # 回答者への通知インスタンスを作成
      notification_answer = current_user.active_notifications.new(
        room_id: id,
        visited_id: users[1].id,
        action: 'like'
      )
      # 質問者への通知インスタンスを作成
      notification_questioner = current_user.active_notifications.new(
        room_id: id,
        visited_id: users[0].id,
        action: 'like'
      )
      # 自分自身の投稿に対するいいねの場合は、通知済みとする
      if notification_answer.visitor_id == current_user.id || notification_answer.visited_id == current_user.id
        notification_answer.checked = true
      end
      # 質問者と回答者への通知をレコードにコミットする
      if notification_answer.valid?
        notification_answer.save
        notification_questioner.save
      end
    end
  end

  def create_notification_comment!(current_user, message_id, user_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Message.select(:user_id).where(room_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, message_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, message_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, message_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      room_id: id,
      message_id: message_id,
      visited_id: visited_id,
      action: 'message'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    notification.checked = true if notification.visitor_id == notification.visited_id
    notification.save if notification.valid?
  end
end
