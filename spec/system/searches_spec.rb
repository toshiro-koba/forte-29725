require 'rails_helper'

RSpec.describe '検索', type: :system do
  before do
    # 検索用の質問を作成する
    @entry = FactoryBot.create(:entry)
    @user = FactoryBot.create(:user)
    @game_tag = FactoryBot.create(:game_tag)
  end
  context '検索にヒットしたとき' do
    it '検索フォームに入力した値を含む質問が登録されていると、検索にヒットすること' do
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

      # キーワードを検索フォームに入力する
      fill_in 'keyword', with: post
      find('#keyword').native.send_keys(:return)

      # 入力したキーワードを含む質問が、ブラウザに表示されていることを確認する
      within 'main' do # スコープを絞る
        expect(page).to have_content(post)
      end
    end
  end

  context '検索にヒットしないとき' do
    it '検索フォームに入力した値を含む質問が登録されていないと、検索にヒットしないこと' do
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

      # キーワードを検索フォームに入力する
      non_existent_question = "#{post}add"
      fill_in 'keyword', with: non_existent_question
      find('#keyword').native.send_keys(:return)
      sleep 1

      # 入力したキーワードを含む質問が、ブラウザに表示されないことを確認する
      within 'main' do # スコープを絞る
        expect(page).to have_no_content(post)
      end
    end
  end
end
