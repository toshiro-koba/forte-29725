# Forte

# 概要
トップランカー、強くなりたいゲーマー向けの一問一答サービスです。
金銭的サポートも可能です。

# 本番環境

# 制作背景
好きなことを追求して極限まで労力をかけている人にきちんとお金が回って、その人がやったことに価値があるんだと証明したい。
# 機能一覧
### 認証機能
- ゲストユーザーログイン機能

### 質問機能
- 回答して欲しいユーザー、ゲームタイトル、質問タイトル、質問文を入力して質問できる
- 質問回答ともに、非同期で一度もページ遷移せずにできる

### ギフト機能
- 外部API(Payjp)にてトークンを取得
- かんたんギフト機能

### ユーザー機能
- ユーザー登録機能(ニックネーム, メールアドレス, パスワード)
- ユーザー情報編集機能
- プロフィール機能
- プロフィール登録機能(プロフィール画像, SNS, 配信サイト, 自己紹介文)
- プロフィール画像プレビュー機能(Ajaxによる非同期表示が可能)

### 検索機能
- 質問を検索できる

### ゲームタグお気に入り機能
- 好きなゲームをお気に入り登録できる
- お気に入り登録を解除できる

### フォロー機能
- 他のユーザーをフォローできる
- フォロー解除できる

### いいね機能
- いいねできる(Ajaxを利用した非同期通信が可能)

# DEMO

# 工夫したポイント
- 質問回答ともに、ページ遷移なくできること
- ギフトで相手をサポートできるところ

# 使用技術・環境
### フロントエンド
- HTML/CSS
- javascript
- jQuery

### バックエンド
- Ruby 2.6.5
- Rails 6.0.3

### 開発環境
- Docker/docker-compose
- MySQL 5.6.47

### 本番環境
- AWS(EC2, S3, VPC, Route53)
- Nginx, unicorn
- Capistrano

# その他技術
- Ajaxによる非同期通信
- Rspecを導入しテストを記述(単体/結合)
- Rubocupを導入しコードを整形
- Git チーム開発を意識したissue, プルリクエスト, マイルストーンの活用

# 課題や今後実装したい機能
- 本番環境にDockerを導入
- 通知機能の追加実装

# DB設計
<img width="800px" alt="forte_ER図" src="https://user-images.githubusercontent.com/56726628/95676423-fd09b980-0bf8-11eb-9eea-fe55c8d59f4b.png">

## users テーブル

| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| nickname | string | null: false |
| email    | string | null: false |
| password | string | null: false |

### Association

- has_many :entries
- has_many :rooms, through: :entries
- has_many :messages
- has_many :gifts
- has_many :giftings, through: :gifts, source: :giver
- has_many :reverse_of_gifts, class_name: 'Gift', foreign_key: 'giver_id'
- has_many :receivings, through: :reverse_of_gifts, source: :user
- has_many :bookmarks
- has_many :game_tags, through: :bookmarks
- has_many :relationships
- has_many :followings, through: :relationships, source: :follow
- has_many :reverse_of_relationships, class_name: 'Relationship'
- has_many :followers, through: :reverse_of_relationships, source: :user
- has_one  :profile
- has_many :likes, dependent: :destroy
- has_many :like_rooms, through: :likes, source: :room
- has_many :active_notifications, class_name: 'Notification'
- has_many :passive_notifications, class_name: 'Notification'


## entries テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| user     | references | null: false, foreign_key: true |
| room     | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :room


## rooms テーブル

| Column         | Type       | Options                                        |
| -------------- | ---------- | ---------------------------------------------- |
| question_title | string     | null: false                                    |

### Association

- has_many :entries
- has_many :users, through: :entries
- has_many :messages
- has_many :room_game_tags
- has_many :game_tags, through: :room_game_tags
- has_many :likes
- has_many :likers, through: :likes, source: :user
- has_one :notification


## messages テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| content | text       | null: false                    |
| user    | references | null: false, foreign_key: true |
| room    | references | null: false, foreign_key: true |

### Association 
- belongs_to :room
- belongs_to :user
- has_one :notification


## gifts テーブル

| Column | Type       | Options                                        |
| ------ | ---------- | ---------------------------------------------- |
| user   | references | null: false, foreign_key: true                 |
| giver  | references | null: false, foreign_key: { to_table: :users } |
| price  | integer    | null: false                                    |

### Association 
- belongs_to :user
- belongs_to :giver, class_name: 'User'
- has_one :notification


## bookmarks テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| user     | references | null: false, foreign_key: true |
| game_tag | references | null: false, foreign_key: true |

### Association 

- belongs_to :user
- belongs_to :game_tag


## room_game_tags テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| room     | references | null: false, foreign_key: true |
| game_tag | references | null: false, foreign_key: true |

### Association 

- belongs_to :room
- belongs_to :game_tag

## game_tags テーブル

| Column     | Type   | Options     |
| ---------- | ------ | ----------- |
| game_title | string | null: false |

### Association 

- has_many :room_game_tags
- has_many :rooms, through: :room_game_tags
- has_many :bookmarks
- has_many :users, through: :bookmarks


## relationships テーブル

| Column | Type       | Options                                        |
| ------ | ---------- | ---------------------------------------------- |
| user   | references | null: false, foreign_key: true                 |
| follow | references | null: false, foreign_key: { to_table: :users } |

### Association 

- belongs_to :user
- belongs_to :follow, class_name: 'User'


## profiles テーブル

| Column            | Type       | Options     |
| ----------------- | ---------- | ----------- |
| link_to_sns       | string     |             |
| link_to_webcast   | string     |             |
| self_introduction | text       |             |
| image             | string     |             |
| user              | references | null: false |

### Association 

- belongs_to :user


## likes テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| room   | references | null: false, foreign_key: true |

### Association 

- belongs_to :user
- belongs_to :room


## notifications テーブル

| Column      | Type    | Options                     |
| ----------- | ------- | --------------------------- |
| visitor_id  | integer | null: false                 |
| visited_id  | integer | null: false                 |
| message_id  | integer |                             |
| gift_id     | integer |                             |
| action      | string  | null: false, default: ''    |
| checked     | boolean | null: false, default: false |

### Association 
- belongs_to :visitor, class_name: 'User'
- belongs_to :visited, class_name: 'User'
- belongs_to :message
- belongs_to :gift
