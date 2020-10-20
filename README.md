# Forte
<img width="800px" alt="forte" src="https://user-images.githubusercontent.com/56726628/96543924-7338ab00-12e0-11eb-867f-548be3a3f2af.jpg">

# 概要
「もっと強くなりたい」
今より強くなりたいゲーマーに向けた、一問一答サービスです。

# URL
（ここにURLを貼る）
「簡単ログイン」ボタンからテストユーザーとしてログインできます。

# 制作の背景
もっと上手くなりたい！
　
　
「でもどうしたら...トッププレイヤーに気軽に聞けたらいいな...」
　
 
ゲームをしていてこう考えた人は多いはず・・・そのような人たちが強くなれたら、という強い想いからこのアプリが完成しました。
　
 
同時に、トッププレイヤーの方の価値が最大化される仕組みを目指しました。

# 機能一覧
* 質問機能
  * 回答して欲しいユーザー、ゲームタイトル、質問タイトル、質問文を入力して質問できる
  * 質問回答ともに、非同期で一度もページ遷移せずにできる
  * 質問を検索できる
* ギフト機能
  * 外部API(Payjp)にてトークンを取得
  * __かんたんギフトボタンがございます__
* ユーザー機能
  * 好きなゲームをお気に入り登録できる
  * プロフィール登録機能(プロフィール画像, SNS, 配信サイト, 自己紹介文)
* 通知機能
  * 質問、回答、ギフト、フォロー、いいねの通知が届く
* ゲームお気に入り機能
* いいね機能
* フォロー機能
* レスポンシブデザイン

# 環境・使用技術
### フロントエンド
- HTML/CSS
- JavaScript, jQuery, Ajax

### バックエンド
- Ruby 2.6.5
- Rails 6.0.3

### 開発環境
- Docker/Docker-compose
- MySQL 5.6.47


### 本番環境
- AWS (EC2, Route53, S3, ALB)
- MariaDB
- Nginx, unicorn
- circleci (自動テスト/自動デプロイ)
- capistorano (自動デプロイ)

### インフラ構成図
<img width="800px" alt="forteインフラ図" src="https://user-images.githubusercontent.com/56726628/96541781-afb5d800-12db-11eb-81d6-7fd92e55ab9e.png">

### テスト
- RSpec(単体/結合)
- circleciを用いてテスト環境のdockerコンテナを作成し、自動テスト

### その他技術
- Ajaxによる非同期通信(いいね)
- HTTPS接続
- Rubocupを導入しコードを整形
- Git チーム開発を意識したissue, プルリクエスト, マイルストーンの活用
- pushと連動し、自動テスト、自動デプロイ
- シームレスな設計(質問、回答が一度のページ遷移で可能。しかも非同期)
- プロフィール画像プレビュー機能(Ajaxによる非同期表示が可能)

### ER図
<img width="800px" alt="forteER図" src="https://user-images.githubusercontent.com/56726628/96457303-8e60d780-125a-11eb-8581-c0b3ef0aee8b.png">

# About me
[Qiita](https://qiita.com/kobachii) 　   [LAPRAS](https://lapras.com/public/BDGZDNO)  　  [compass](https://connpass.com/user/Toshiro_Koba/) 　   [Twitter](https://twitter.com/KobaToshiro)

