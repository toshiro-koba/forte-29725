# テーブル設計

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
- has_many :gift_entries
- has_many :gifts, through: :gift_entries
- has_many :bookmarks
- has_many :game_tags, through: :bookmarks
- has_many :relationships
- has_many :followings, through: :relationships, source: :follow
- has_many :reverse_of_relationships, class_name: 'Relationship'
- has_many :followers, through: :reverse_of_relationships, source: :user
- has_one  :profile
- has_one  :subscriber
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
| game_tag       | references | null: false, foreign_key: true                 |

### Association

- has_many :entries
- has_many :users, through: :entries
- has_many :messages
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


## gift_entries テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| gift   | references | null: false, foreign_key: true |

### Association 

- belongs_to :user
- belongs_to :gift


## gifts テーブル

| Column | Type       | Options                                        |
| ------ | ---------- | ---------------------------------------------- |
| giver  | references | null: false, foreign_key: { to_table: :users } |
| price  | integer    | null: false                                    |

### Association 

- has_many :gift_entries
- has_one :giver, class_name: 'User', through: :gift_entries
- has_one :notification


## bookmarks テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| user     | references | null: false, foreign_key: true |
| game_tag | references | null: false, foreign_key: true |

### Association 

- belongs_to :user
- belongs_to :game_tag


## game_tags テーブル

| Column    | Type   | Options     |
| --------- | ------ | ----------- |
| game_name | string | null: false |

### Association 

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

| Column          | Type       | Options     |
| --------------- | ---------- | ----------- |
| link_to_sns     | string     |             |
| link_to_webcast | string     |             |
| user            | references | null: false |

### Association 

- belongs_to :user


## subscribers テーブル

| Column | Type       | Options     |
| ------ | ---------- | ----------- |
| user   | references | null: false |

### Association 

- belongs_to :user


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
