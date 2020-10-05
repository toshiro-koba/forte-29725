require 'rails_helper'

RSpec.describe 'プロフィールの新規登録、変更', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'プロフィールの新規登録、変更に成功したとき' do
    it '値を登録すると、プロフィールの新規登録、変更に成功すること' do
      # サインインする
      sign_in(@user)

      # マイページに遷移する
      find('.more').hover
      find('.my-page').click

      # プロフィール登録ページに遷移する
      find('.profile__hover-action').hover
      click_link 'プロフィールを登録'

      # プロフィール登録ページに遷移していることを確認する
      expect(current_path).to eq new_user_profile_path(@user)

      # 値をテキストフォームに入力する
      post = 'test self introduction'
      fill_in 'SNS', with: 'test/sns'
      fill_in '配信サイト', with: 'test/webcast'
      fill_in '自己紹介', with: post

      # 送信した値がDBに保存されていることを確認する
      expect  do
        find('.user-edit__hover-action').hover
        find('input[name="commit"]').click
      end.to change { Profile.count }.by(1)

      # マイページに遷移していることを確認する
      expect(current_path).to eq user_path(@user)

      # 送信した値がブラウザに表示されていることを確認する
      expect(page).to have_content(post)

      # プロフィール登録ページに遷移する
      find('.profile__hover-action').hover
      click_link 'プロフィールを編集'

      # 値をテキストフォームに入力する
      post = 'test self introduction update'
      fill_in 'SNS', with: 'test/sns'
      fill_in '配信サイト', with: 'test/webcast'
      fill_in '自己紹介', with: post

      # レコード数は変化しないことを確認する
      expect  do
        find('.user-edit__hover-action').hover
        find('input[name="commit"]').click
      end.not_to change { Profile.count }

      # マイページに遷移していることを確認する
      expect(current_path).to eq user_path(@user)

      # 送信した値がブラウザに表示されていることを確認する
      expect(page).to have_content(post)
    end
  end
end
