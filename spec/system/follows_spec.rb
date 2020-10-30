require 'rails_helper'

RSpec.describe 'フォロー', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:user)
  end
  context 'フォローに成功したとき' do
    it 'まだフォローしてないユーザーなら、フォローに成功すること' do
      # サインインする
      sign_in(@user)
      expect(page).to have_content("#{@other_user.nickname}の詳細ページ")

      # フォローする相手のユーザー詳細ページに遷移する
      click_link "#{@other_user.nickname}の詳細ページ"

      # ユーザー詳細ページに遷移していることを確認する
      expect(current_path).to eq user_path(@other_user)

      # フォローがDBに保存されていることを確認する
      expect do
        find('.follow__hover-action').hover
        click_button 'フォロー'
      end.to change { Relationship.count }.by(1)

      # 文字列「フォロー中」が、ブラウザに表示されていることを確認する
      expect(page).to have_content('フォロー中')
    end
  end

  context 'フォロー解除に成功したとき' do
    it 'すでにフォローしているユーザーなら、フォロー解除に成功すること' do
      # サインインする
      sign_in(@user)
      expect(page).to have_content("#{@other_user.nickname}の詳細ページ")

      # フォローする相手のユーザー詳細ページに遷移する
      click_link "#{@other_user.nickname}の詳細ページ"

      # ユーザー詳細ページに遷移していることを確認する
      expect(current_path).to eq user_path(@other_user)

      # フォローがDBに保存されていることを確認する
      expect do
        find('.follow__hover-action').hover
        click_button 'フォロー'
      end.to change { Relationship.count }.by(1)

      # フォローがDBから削除されていることを確認する
      expect do
        find('.unfollow__hover-action').hover
        click_button '解除'
      end.to change { Relationship.count }.by(-1)

      # 文字列「フォロー中」が、ブラウザに表示されていないことを確認する
      expect(page).to have_no_content('フォロー中')
    end
  end
end
