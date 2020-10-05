require 'rails_helper'

RSpec.describe 'お気に入り登録', type: :system do
  before do
    @user = FactoryBot.create(:user)
    # お気に入り登録用の、ゲームタグを作成する
    @game_tag = FactoryBot.create(:game_tag)
  end
  context 'お気に入り登録に成功するとき' do
    it 'ゲームタグを選択してお気に入り登録ボタンを押すと、お気に入りに成功すること' do
      # サインインする
      sign_in(@user)

      # マイページに遷移する
      find('.more').hover
      find('.my-page').click

      # お気に入り登録ページに遷移する
      find('.game_tag__registration__hover-action').hover
      click_link 'ゲームを登録する'

      # 登録したいゲームを選択する
      select @game_tag.game_title, from: 'bookmark[game_tag_id]'

      # 送信した値がDBに保存されていることを確認する
      expect do
        find('.game-tag__hover-action').hover
        find('input[name="commit"]').click
      end.to change { Bookmark.count }.by(1)

      # マイページに遷移していることを確認する
      expect(current_path).to eq user_path(@user)

      # 送信した値がブラウザに表示されていることを確認する
      expect(page).to have_content(@game_tag.game_title)
    end
  end

  context 'お気に入り登録に失敗したとき' do
    it '送る値が空の為、お気に入りに失敗すること' do
      # サインインする
      sign_in(@user)

      # マイページに遷移する
      find('.more').hover
      find('.my-page').click

      # お気に入り登録ページに遷移する
      find('.game_tag__registration__hover-action').hover
      click_link 'ゲームを登録する'

      # 登録ボタンを押しても、ブックマークモデルのカウントは上がらないことを確認する
      expect do
        find('.game-tag__hover-action').hover
        find('input[name="commit"]').click
      end.not_to change { Bookmark.count }

      # お気に入り登録ページにいることを確認する
      expect(current_path).to eq user_bookmarks_path(@user)
    end
  end
end
