require 'rails_helper'

RSpec.describe "Notifications", type: :system do
  before do
    # 中間テーブルを作成して、usersテーブルとroomsテーブルのレコードを作成する
    @entry = FactoryBot.create(:entry)
    @user = FactoryBot.create(:user)
    @game_tag = FactoryBot.create(:game_tag)

    #followに関するインスタンス
    @other_user = FactoryBot.create(:user)
    @giver = FactoryBot.create(:user)
    @receiver = FactoryBot.create(:user)
  end

  context '質問回答に関する通知が成功したとき' do
    it '質問の登録に成功すると、通知が作成される。回答の登録に成功すると、通知が作成される' do
      # サインインする
      sign_in(@entry.user)

      # 値をテキストフォームに入力する
      post = '質問テスト'
      within '.question-form' do # スコープを絞る
        select @user.nickname, from: 'room[user_ids][]', match: :first
      end
      select @game_tag.game_title, from: 'room[game_tag_ids][]'
      fill_in 'room_message[question_title]', with: post
      fill_in 'room_message[content]', with: post

      # 送信した値がDBに保存されていることを確認する
      expect  do
        find('input[name="commit"]').click
        sleep 0.1
      end.to change { Notification.count }.by(1)

      # 投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq root_path

      # 送信した値がブラウザに表示されていることを確認する
      expect(page).to have_content(post)

      # 回答して欲しいユーザーでログインし直す
      sign_out(@entry.user)
      sign_in(@user)
      sleep 1.0

      # 値をテキストフォームに入力する
      post = '回答テスト'
      fill_in 'message[content]', with: post

      # 送信した値がDBに保存されていることを確認する
      within '.room-name' do # スコープを絞る
        expect do
          find('input[name="commit"]').click
          sleep 0.1
        end.to change { Notification.count }.by(1)
      end

      # 投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq root_path

    end
  end

  context 'フォローに関する通知が成功したとき' do
    it 'フォローの登録に成功すると、通知が作成される。' do
      # サインインする
      sign_in(@user)
      sleep 1.0
      expect(page).to have_content("#{@other_user.nickname}の詳細ページ")

      # フォローする相手のユーザー詳細ページに遷移する
      click_link "#{@other_user.nickname}の詳細ページ"

      # ユーザー詳細ページに遷移していることを確認する
      expect(current_path).to eq user_path(@other_user)

      # フォローがDBに保存されていることを確認する
      expect do
        find('.follow__hover-action').hover
        click_button 'フォロー'
      end.to change { Notification.count }.by(1)

    end
  end

  context 'フォロー解除に関する通知は作成されないとき' do
    it 'フォロー解除に成功しても、通知は作成されない。' do
      # サインインする
      sign_in(@user)
      sleep 1.0

      # フォローする相手のユーザー詳細ページに遷移する
      click_link "#{@other_user.nickname}の詳細ページ"

      # ユーザー詳細ページに遷移していることを確認する
      expect(current_path).to eq user_path(@other_user)

      # 通知がDBに保存されていることを確認する
      expect do
        find('.follow__hover-action').hover
        click_button 'フォロー'
      end.to change { Notification.count }.by(1)

      # 通知がDBに作成されないことを確認する
      expect do
        find('.unfollow__hover-action').hover
        click_button '解除'
      end.to change { Notification.count }.by(0)

    end
  end

  context 'ギフティングに関する通知が成功したとき' do
    it 'ギフティングの登録に成功すると、通知が作成される。' do
      # サインインする
      sign_in(@giver)
      expect(page).to have_content("#{@receiver.nickname}の詳細ページ")

      # ギフトを送る相手のユーザー詳細ページに遷移する
      click_link "#{@receiver.nickname}の詳細ページ"

      # ユーザー詳細ページに遷移していることを確認する
      expect(current_path).to eq user_path(@receiver)

      # 「ギフト」ボタンを押して、ギフトページに遷移する
      find('.gift__hover-action').hover
      sleep 1.0
      click_link 'ギフト'

      # ギフトページに遷移していることを確認する
      expect(current_path).to eq user_gifts_path(@receiver)

      # 値をテキストフォームに入力する
      price = 777
      fill_in 'gift[number]', with: 4_242_424_242_424_242
      fill_in 'gift[exp_month]', with: 12
      fill_in 'gift[exp_year]', with: 24
      fill_in 'gift[cvc]', with: 123
      fill_in 'gift[price]', with: price

      # 送信した値がDBに保存されていることを確認する
      expect  do
        find('.gift-submit__hover-action').hover
        find('input[name="commit"]').click
        sleep 5.0
      end.to change { Notification.count }.by(1)

      # トップページに遷移していることを確認する
      expect(current_path).to eq root_path

    end
  end
end
