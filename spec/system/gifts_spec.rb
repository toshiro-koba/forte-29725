require 'rails_helper'
RSpec.describe 'ギフティング', type: :system do
  before do
    @giver = FactoryBot.create(:user)
    @receiver = FactoryBot.create(:user)
  end
  context 'ギフティングに成功したとき' do
    it '正しい値を登録すると、ギフティングに成功すること' do
      # サインインする
      sign_in(@giver)
      expect(page).to have_content("#{@receiver.nickname}の詳細ページ")

      # ギフトを送る相手のユーザー詳細ページに遷移する
      click_link "#{@receiver.nickname}の詳細ページ"
      

      # ユーザー詳細ページに遷移していることを確認する
      expect(current_path).to eq  user_path(@receiver)

      # 「ギフトする」ボタンを押して、ギフトページに遷移する
      click_link "ギフトする！"

      # ギフトページに遷移していることを確認する
      expect(current_path).to eq  user_gifts_path(@receiver)

      # 値をテキストフォームに入力する
      price = 777
      fill_in 'gift[number]', with: 4242424242424242
      fill_in 'gift[exp_month]', with: 12
      fill_in 'gift[exp_year]', with: 24
      fill_in 'gift[cvc]', with: 123
      fill_in 'gift[price]', with: price

      # 送信した値がDBに保存されていることを確認する
      expect{
        find('input[name="commit"]').click
        sleep 1.0 #指定した秒数だけ待ってくれる、神
      }.to change { Gift.count }.by(1)

      # トップページに遷移していることを確認する
      expect(current_path).to eq  root_path

      # マイページに遷移する
      find(".more").hover
      find('.my-page').click

      # 送信した値がブラウザに表示されていることを確認する
      expect(page).to have_content(price)

    end
  end

  context 'ギフティングに失敗したとき' do
    it '送る値が空の為、ギフティングに失敗すること' do
      # サインインする
      sign_in(@giver)
      expect(page).to have_content("#{@receiver.nickname}の詳細ページ")

      # ギフトを送る相手のユーザー詳細ページに遷移する
      click_link "#{@receiver.nickname}の詳細ページ"

      # ユーザー詳細ページに遷移していることを確認する
      expect(current_path).to eq  user_path(@receiver)

      # 「ギフトする」ボタンを押して、ギフトページに遷移する
      click_link "ギフトする！"

      # ギフトページに遷移していることを確認する
      expect(current_path).to eq  user_gifts_path(@receiver)

      # 送信した値がDBに保存されていることを確認する
      expect{
        find('input[name="commit"]').click
        sleep 1.0
      }.not_to change { Gift.count }

      # ギフトページにいることを確認する
      expect(current_path).to eq  user_gifts_path(@receiver)
    end
  end
end