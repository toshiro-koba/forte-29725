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
      find(".more").hover
      find('.my-page').click

      # お気に入り登録ページに遷移する
      click_link "好きなゲームをお気に入り登録する"

      # 登録したいゲームを選択する
      select @game_tag.game_title, from: "game_tag_id"

      # 送信した値がDBに保存されていることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Bookmark.count }.by(1)

      # トップページに遷移していることを確認する
      expect(current_path).to eq  root_path

      # マイページに遷移する
      find(".more").hover
      find('.my-page').click

      # 送信した値がブラウザに表示されていることを確認する
      expect(page).to have_content(@game_tag.game_title)
    end
  end
end
