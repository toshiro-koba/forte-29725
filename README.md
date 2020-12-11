<p align="center">
<img width="100%" alt="forte" src="https://user-images.githubusercontent.com/56726628/97288428-2b3df900-1889-11eb-9371-c13b4daee026.jpg">
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
　
 :warning: 2020/12/11から公開停止
 
「簡単ログイン」ボタンからテストユーザーとしてログインできます。

<h2> 🎲 制作の背景 </h2>

もっと上手くなりたい！
　
 
「でもどうしたら...。トッププレイヤーに気軽に聞けたらいいな...」
　
 
ゲームに熱中してこう考えた人は多いはず・・・そのような人達が強くなる手助けができたら、という強い想いからこのアプリが完成しました。
　
 
同時に、トッププレイヤーの価値が最大化される仕組みを目指しました。

<h2> 🎲 機能一覧 </h2>

* 質問機能(Ajax)
  * 質問回答ともに、ページ遷移せずに非同期通信が可能です
  * 質問検索も可能です
  * 質問一覧からゲームタイトルをクリックすると、同じゲームの質問を閲覧できます

* ギフト機能
  * __「簡単ギフト」__ ボタンから、カード情報の入力を省略してギフトできます
  * 外部APIを利用したカード決済が可能です
    * カード番号 : 4242424242424242
    * 有効期限　: 12/2024
    * セキュリティコード : 123
* ユーザー機能
* プロフィール機能
    * プロフィール画像は、非同期でプレビュー表示できます
* 通知機能
  各種アクションに対して通知が届きます
    * 質問
    * 回答
    * ギフト
    * フォロー
    * いいね
* ゲームお気に入り機能
    * ゲームタイトルをクリックすると、関連する質問を閲覧できます
    * 一度登録したゲームのお気に入りを解除することもできます
* いいね機能(Ajax)
* フォロー機能
* レスポンシブデザイン
　
 <img width="100%" alt="responsive" src="https://user-images.githubusercontent.com/56726628/96868308-cf4e2b80-14a8-11eb-8a58-7b04ff4ab819.png">

<h2> 🎮 環境・使用技術 </h2>

### フロントエンド
- HTML/CSS
- JavaScript

### バックエンド
- Ruby 2.6.5
- Rails 6.0.3

### Webサーバー
- Nginx : 1.18.0

### アプリケーションサーバー
- （開発環境）Puma : 4.3.3
- （本番環境）Unicorn : 5.4.1

### データベース
- （開発環境）MySQL 5.6.47
- （本番環境）MariaDB : 5.5.64

### インフラ
- （開発環境のみ）Docker : 19.03.13
- docker-compose : 1.27.4
- AWS (EC2, S3, VPC, Route53, ALB, ACM)
- Git, GitHub
- circleCI : 2.1
- Capistrano : 3.14.1

### インフラ構成図
<img width="800px" alt="forteインフラ図" src="https://user-images.githubusercontent.com/56726628/96541781-afb5d800-12db-11eb-81d6-7fd92e55ab9e.png">

### テスト
- RSpec(単体/結合) 合計74個
- circleCIを用いてテスト環境のdockerコンテナを作成し、自動テスト

### その他技術
- 質問、回答をページ遷移せずに非同期で可能
- 非同期通信(質問、回答、いいね、プレビュー画像表示)
- AWS(Route53, ALB, ACM)を利用したHTTPS接続
- 外部API(Payjp)を使った決済処理
- Animate.cssを導入
- モーダル表示
- ページネーション
- Git チーム開発を意識したissue, プルリクエスト, マイルストーンの活用
- Rubocupを導入しコードを整形
- pushと連動し、自動テスト、自動デプロイ


### ER図
<img width="800px" alt="forteER図" src="https://user-images.githubusercontent.com/56726628/97287953-8b806b00-1888-11eb-9622-db0c6938d3b4.png">

### 工夫した点
- 質問回答がページ遷移せずに、非同期で可能なことです
- 開発環境にdocker、本番環境にAWSを利用して、インフラの実用的な理解を深めました
- チーム開発を意識してGitHubを活用しました(Milestone, Issue, Pull request, Merge)
- リモートリポジトリへのpushと連動し、自動テスト、自動デプロイすることで、効率化を実現しました
- JavaScriptによる非同期通信や、ホバーアクションなど、UI/UXの改善にも注力しました

### 今後改善する点
- 本番環境構成の冗長化(AWS, docker)
- データを処理するアルゴリズムやパフォーマンスの改善(SQL, Ruby)
- ユーザー目線で機能を改善(ストックしている質問の一覧表示など)
- ユーザー目線でのデザインを改善(サービスの動線)

<h2> 👀 About me </h2>

<p >
現在24歳。新卒で1年弱、3Dソフトを使って航空宇宙機器設計をしておりました。
</p>

[Wantedly](https://www.wantedly.com/users/140981045)　[Qiita](https://qiita.com/kobachii) 　   [LAPRAS](https://lapras.com/public/BDGZDNO)  　  [connpass](https://connpass.com/user/Toshiro_Koba/) 　   [Twitter](https://twitter.com/KobaToshiro)

