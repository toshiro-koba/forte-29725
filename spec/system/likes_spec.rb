require 'rails_helper'

RSpec.describe 'Likes', type: :system do
  before do
    # 中間テーブルを作成して、usersテーブルとroomsテーブルのレコードを作成する
    @entry = FactoryBot.create(:entry)
    @user = FactoryBot.create(:user)
    @game_tag = FactoryBot.create(:game_tag)
  end

  context 'いいねに成功したとき' do
    it 'いいねしていない質問のいいねボタンを押すと、いいねのカウントが一つ増えて表示される' do
      # サインインする
      sign_in(@entry.user)

      # 値をテキストフォームに入力する
      post = '質問テスト'
      select @user.nickname, from: 'room[user_ids][]'
      select @game_tag.game_title, from: 'room[game_tag_ids][]'
      fill_in 'room_message[question_title]', with: post
      fill_in 'room_message[content]', with: post

      # 送信した値がDBに保存されていることを確認する
      expect  do
        find('input[name="commit"]').click
        sleep 0.1
      end.to change { Message.count }.by(1)

      # 投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq root_path

      # 送信した値がブラウザに表示されていることを確認する
      expect(page).to have_content(post)

      # 回答して欲しいユーザーでログインし直す
      sign_out(@entry.user)
      sign_in(@user)

      # 値をテキストフォームに入力する
      post = '回答テスト'
      fill_in 'message[content]', with: post

      # 送信した値がDBに保存されていることを確認する
      within '.room-name' do # スコープを絞る
        find('input[name="commit"]').click
        sleep 0.1
      end

      # 投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq root_path

      # いいねがDBに保存されていることを確認する
      within '.room-name' do # スコープを絞る
        expect do
          find('.like-yet-btn').click
          sleep 0.1
        end.to change { Like.count }.by(1)
      end
    end
  end

  context 'いいねを解除できるとき' do
    it '既にいいねした質問のいいねボタンを押すと、いいねのカウントが一つ減って表示される' do
      # サインインする
      sign_in(@entry.user)

      # 値をテキストフォームに入力する
      post = '質問テスト'
      select @user.nickname, from: 'room[user_ids][]'
      select @game_tag.game_title, from: 'room[game_tag_ids][]'
      fill_in 'room_message[question_title]', with: post
      fill_in 'room_message[content]', with: post

      # 送信した値がDBに保存されていることを確認する
      expect  do
        find('input[name="commit"]').click
        sleep 0.1
      end.to change { Message.count }.by(1)

      # 投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq root_path

      # 送信した値がブラウザに表示されていることを確認する
      expect(page).to have_content(post)

      # 回答して欲しいユーザーでログインし直す
      sign_out(@entry.user)
      sign_in(@user)

      # 値をテキストフォームに入力する
      post = '回答テスト'
      fill_in 'message[content]', with: post

      # 送信した値がDBに保存されていることを確認する
      within '.room-name' do # スコープを絞る
        find('input[name="commit"]').click
        sleep 0.1
      end

      # 投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq root_path

      # いいねがDBに保存されていることを確認する
      within '.room-name' do # スコープを絞る
        expect do
          find('.like-yet-btn').click
          sleep 0.1
        end.to change { Like.count }.by(1)
      end

      # いいねがDBから削除されていることを確認する
      within '.room-name' do # スコープを絞る
        expect do
          find('.liked-btn').click
          sleep 0.1
        end.to change { Like.count }.by(-1)
      end
    end
  end
end
