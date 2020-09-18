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

### Association

- has_many :entries
- has_many :users, through: :entries
- has_many :messages
- has_many :room_game_tags
- has_many :game_tags, through: :room_game_tags
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
