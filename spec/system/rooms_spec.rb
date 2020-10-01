require 'rails_helper'

RSpec.describe "質問回答機能", type: :system do
  before do
    # 中間テーブルを作成して、usersテーブルとroomsテーブルのレコードを作成する
    @entry = FactoryBot.create(:entry)
    @user = FactoryBot.create(:user)
    @game_tag = FactoryBot.create(:game_tag)
  end

  context '質問登録に失敗したとき' do
    it '送る値が空の為、質問登録に失敗すること' do
      # サインインする
      sign_in(@entry.user)
      # DBに保存されていないことを確認する
      expect{
        find('input[name="commit"]').click
      }.not_to change { Message.count }
      # 元のページに戻ってくることを確認する
      expect(current_path).to eq  root_path
    end
  end

  context '質問回答に成功したとき' do
    it '質問(回答して欲しいユーザー、ゲームタイトル、質問タイトル、質問文)の登録に成功すると、ページ遷移無く、登録した内容が表示されており、回答して欲しいユーザーがサインインし直した後、回答(回答文)の登録に成功すると、、ページ遷移無く、登録した内容が表示されている' do
      # サインインする
      sign_in(@entry.user)

      # 値をテキストフォームに入力する
      post = "質問テスト"
      select @user.nickname, from: "room[user_ids][]"
      select @game_tag.game_title, from: "room[game_tag_ids][]"
      fill_in 'room_message[question_title]', with: post
      fill_in 'room_message[content]', with: post

      # 送信した値がDBに保存されていることを確認する
      expect{
        find('input[name="commit"]').click
        sleep 0.1 #指定した秒数だけ待ってくれる、神
      }.to change { Message.count }.by(1)

      # 投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq  root_path

      # 送信した値がブラウザに表示されていることを確認する
      expect(page).to have_content(post)

      # 回答して欲しいユーザーでログインし直す
      find(".more").hover
      find('.log-out').click
      sign_in(@user)

      # 値をテキストフォームに入力する
      post = "回答テスト"
      fill_in 'message[content]', with: post

      # 送信した値がDBに保存されていることを確認する
      within '.question-space' do #スコープを絞る
        expect{
          find('input[name="commit"]').click
          sleep 0.1
        }.to change { Message.count }.by(1)
      end
      
      # 投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq  root_path

      # 送信した値がブラウザに表示されていることを確認する
      expect(page).to have_content(post)
    end   
  end
end