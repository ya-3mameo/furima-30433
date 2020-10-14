# テーブル設計

## usersテーブル

| Column      | Type    | Options                   |
| ----------- | ------- | ------------------------- |
| nickname    | string  | null: false, unique: true |
| email       | string  | null: false, unique: true |
| password    | string  | null: false, unique: true |
| full_name   | string  | null: false               |
| furigana    | string  | null: false               |
| birth_year  | integer | null: false               |
| birth_month | integer | null: false               |
| birth_day   | integer | null: false               |

### Association
 - has_many :items
 - has_many :purchases


## itemsテーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| name        | string     | null: false                    |
| description | text       | null: false                    |
| category    | string     | null: false                    |
| status      | string     | null: false                    |
| burden      | string     | null: false                    |
| place       | string     | null: false                    |
| date        | string     | null: false                    |
| price       | integer    | null: false                    |
| user        | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :purchase


## purchasesテーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| user          | references | null: false, foreign_key: true |
| purchase_date | integer    | null: false                    |
| item          | references | null: false, foreign_key: true |


### Association
- belongs_to :item
- has_one :delivery


## deliveriesテーブル

| Column        | Type       | Options                   |
| ------------- | ---------- | ------------------------- |
| postal_number | string     | null: false               |
| prefecture    | string     | null: false               |
| city          | string     | null: false               |
| address       | string     | null: false               |
| building      | string     | null: false               |
| phone_number  | integer    | null: false, unique: true |


### Association

- belongs_to :purchase