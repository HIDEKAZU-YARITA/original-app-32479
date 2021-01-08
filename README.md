# テーブル設計

## customers テーブル

| Column             | Type    | Options                     |
| ------------------ | ------- | --------------------------- |
| email              | string  | null: false, unique: true   |
| encrypted_password | string  | null: false                 |
| last_name          | string  | null: false                 |
| first_name         | string  | null: false                 |
| last_name_kana     | string  | null: false                 |
| first_name_kana    | string  | null: false                 |
| phone_number       | string  | null: false                 |

### Association

- has_many :reservations


## reservations テーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| start_time | datetime   | null: false                    |
| end_time   | datetime   | null: false                    |
| menu_id    | integer    | null: false                    |
| staff_id   | integer    | null: false                    |
| customer   | references | null: false, foreign_key: true |

### Association

- belongs_to :customer
