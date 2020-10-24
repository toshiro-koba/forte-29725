<p align="center">
<img width="100%" alt="forte" src="https://user-images.githubusercontent.com/56726628/97069832-d80c4200-160d-11eb-8384-493ae027130a.jpg">
</p>
<h2 align="center">Forte</h3>
<p align="center">
「もっと強くなりたい」
</p>
<p align="center">
強さを求めるゲーマーへ向けた、一問一答サービスです
</p>


<h2> 🌐 URL </h2>

[https://www.forte2020.net/](https://www.forte2020.net/)
　
 
「簡単ログイン」ボタンからテストユーザーとしてログインできます。

<h2> 🎲 制作の背景 </h2>

もっと上手くなりたい！
　
 
「でもどうしたら...。トッププレイヤーに気軽に聞けたらいいな...」
　
 
ゲームに熱中してこう考えた人は多いはず・・・そのような人達が強くなる手助けができたら、という強い想いからこのアプリが完成しました。
　
 
同時に、トッププレイヤーの価値が最大化される仕組みを目指しました。

<h2> 🎲 機能一覧 </h2>

* 質問機能(Ajax)
  * 回答して欲しい人を選んで質問できる
  * 質問回答ともに、非同期で一度もページ遷移せずにできる
* ギフト機能
  * ユーザー同士で金銭的サポートができる
  * __「簡単ギフト」__ ボタンを押していただくことで、カード情報を入力せずにギフトが可能です。
  * テストカードによる決済処理も可能です。
    * カード番号 : 4242424242424242
    * 有効期限　: 12/2024
    * セキュリティコード : 123
* ユーザー機能
* プロフィール機能
  * プロフ画像、SNS、配信サイトなど登録できる
* 通知機能(以下の通知が届く)
  * 質問
  * 回答
  * ギフト
  * フォロー
  * いいね
* ゲームお気に入り機能
* いいね機能(Ajax)
* フォロー機能
* 質問検索機能
* レスポンシブデザイン
　
 <img width="100%" alt="responsive" src="https://user-images.githubusercontent.com/56726628/96868308-cf4e2b80-14a8-11eb-8a58-7b04ff4ab819.png">

<h2> 🎮 環境・使用技術 </h2>

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
- AWS (VPC, EC2, S3, Route53, ALB, ACM)
- MariaDB
- Nginx, unicorn
- circleci (自動テスト/自動デプロイ)
- capistorano (自動デプロイ)

### インフラ構成図
<img width="800px" alt="forteインフラ図" src="https://user-images.githubusercontent.com/56726628/96541781-afb5d800-12db-11eb-81d6-7fd92e55ab9e.png">

### テスト
- RSpec(単体/結合) 合計68個
- circleciを用いてテスト環境のdockerコンテナを作成し、自動テスト

### その他技術
- 質問、回答が一度のページ遷移不要かつ非同期で可能
- 非同期通信(質問、回答、いいね、プレビュー画像表示)
- AWS(Route53, ALB, ACM)を利用したHTTPS接続
- 外部API(Payjp)を使った決済処理
- モーダル表示
- ページネーション
- Git チーム開発を意識したissue, プルリクエスト, マイルストーンの活用
- Rubocupを導入しコードを整形
- pushと連動し、自動テスト、自動デプロイ


### ER図
<img width="800px" alt="forteER図" src="https://user-images.githubusercontent.com/56726628/96457303-8e60d780-125a-11eb-8581-c0b3ef0aee8b.png">

<h2> 👀 About me </h2>

<p >
現在24歳。新卒で1年弱、3Dソフトを使って航空宇宙機器設計をしておりました。2020年8月からエンジニアを目指して学習を継続しています。
</p>

[Wantedly](https://www.wantedly.com/users/140981045?profile)　[Qiita](https://qiita.com/kobachii) 　   [LAPRAS](https://lapras.com/public/BDGZDNO)  　  [connpass](https://connpass.com/user/Toshiro_Koba/) 　   [Twitter](https://twitter.com/KobaToshiro)

