# テーブル設計

## usersテーブル

| Column               | Type   | Options                   |
| -------------------- | ------ | ------------------------- |
| nickname             | string | null: false               |
| email                | string | null: false, unique: true |
| password             | string | null: false, unique: true |
| family_name          | string | null: false               |
| first_name           | string | null: false               |
| family_name_furigana | string | null: false               |
| first_name_furigana  | string | null: false               |
| birthday             | date   | null: false               |

### Association
 - has_many :items
 - has_many :purchases


## itemsテーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| name             | string     | null: false                    |
| description      | text       | null: false                    |
| category_id      | integer    | null: false                    |
| status_id        | integer    | null: false                    |
| burden_id        | integer    | null: false                    |
| prefecture_id    | integer    | null: false                    |
| delivery_days_id | integer    | null: false                    |
| price            | integer    | null: false                    |
| user             | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :purchase


## ordersテーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |


### Association
- belongs_to :user
- belongs_to :item
- has_one :delivery


## addressesテーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| postal_number | string     | null: false                    |
| prefecture_id | integer    | null: false                    |
| city          | string     | null: false                    |
| house_number  | string     | null: false                    |
| building      | string     |                                |
| phone_number  | string     | null: false                    |
| purchase      | references | null: false, foreign_key: true |


### Association

- belongs_to :purchase