# アプリケーション名
「オリジナルアプリ32479美容室」予約アプリ


# アプリケーション概要
東京下町にある40代男性が経営する美容室(仮想)の予約ができるアプリケーションである


# URL
https://original-app-32479.herokuapp.com/


# テストアカウント

## Basic認証
- ID: administrator
- Password: 22360679

## サインイン
- 電子メールアドレス: test@test.com
- パスワード: test123


# 利用方法

## Basic認証後

### ご予約の状況
左側の[すべて]ボタン、または右上の[Index Reservation]ボタンをクリック

### 担当者別ご予約の状況
左側の[スタッフ名]ボタンをクリック

## サインイン後
上記に加え、次の操作も行います。

### 新規ご予約
- [ご予約の状況]ページの右上にある[To New Reservation]ボタンをクリック
- 予約情報を入力後、右上にある[Create Reservation]ボタンをクリック
- [ご予約の状況]ページで予約されていることを確認

### ご予約の内容
- [ご予約の状況]ページから確認したい予約情報をクリック

### ご予約の変更
- [ご予約の内容]ページの右上にある[Edit Reservation]ボタンをクリック
- 予約情報を入力後、右上にある[Update Reservation]ボタンをクリックし、確認メッセージへ応答
- [ご予約の状況]ページで予約が変更されていることを確認

### ご予約のキャンセル
- [ご予約の内容]ページの右上にある[Destroy Reservation]ボタンをクリックし、確認メッセージへ応答
- [ご予約の状況]ページで予約が変更されていることを確認

### お客様情報の詳細
- 左上にあるお客様名をクリック

### お客様情報の編集
- [お客様情報の詳細]ページの右上にある[Create Customer]ボタンをクリックし、確認メッセージへ応答
- 左上のお客様名をクリックし、パスワード以外の情報が変更されているか確認


# 目指した課題解決
予約業務は営業時間中に電話での対応となることから、お客様施術中のスタッフの対応も必要なケースがある。予約業務をインターネットで行うことで、スタッフは施術中のお客様対応へ集中できること、予約をされるお客様にはお待たせすることなく、24時間(メンテナンス時間帯は除く)予約や予約の変更・キャンセルができるため、お客様満足度および従業員満足度にもつながる。


# 洗い出した要件
- 営業時間は10:00から18:00まで
- 定休日は毎週火曜日
- 従業員(担当者)はスタッフAからEまでの5人
- 終了時刻はメニューにより開始時刻から自動的に算出(1時間/施術)
- 終了時刻は営業時間内とする
- お客様は電子メールアドレスとパスワードでサインイン
- お客様情報には、お名前(読みも含む)と電話番号が必要
- 担当者は同一時間帯にお客様一人の予約を受け付けられる
- お客様は同一時間帯に一つの予約ができる(同一時間帯に複数の担当者を予約できない)
- 前日以前の予約は一覧表示しない
- 現在時刻より前の開始時刻の予約は、変更・削除はできない


# 実装した機能

## トップページ

### 画像
https://gyazo.com/d5312bacd5dbdd90bef417c4133cc442

## お客様管理機能：新規登録
次の情報を入力すると新規登録ができる
- 電子メールアドレス
- パスワード
- お名前
- お名前(カナ)
- 電話番号

### 動画
https://gyazo.com/4e1ab966f92bfc5c08eb1a7ff494901f

## お客様管理機能：サインイン
次の情報を入力するとサインインができる
- 電子メールアドレス
- パスワード

### 動画
https://gyazo.com/72c7ea23cfa0be6aee6bccd62d862351

## お客様詳細表示機能
登録されたお客様情報の内容と過去の予約も含め最新5件の予約状況を表示する

### 動画
https://gyazo.com/bc77aba92a44aff6ba962802901e6cb1

## お客様情報編集機能
登録されたお客様情報が変更できる

### 動画
https://gyazo.com/991836e55bc68052fbb2460740bc9642

## 予約情報登録機能
次の情報を入力すると予約ができる
- 予約日時
- メニュー(プルダウン選択)
- 担当者(プルダウン選択)
ただし、次のケースでは予約ができないようバックエンドで制御している
- 予約しようとしている時間帯に担当者の予約がすでにある場合
- 予約しようとしている時間帯に他の担当者でお客様の予約がすでにある場合
- 予約しようとしている日が火曜日の場合
- 予約しようとしているメニューにより終了時刻が18:00より遅くなる場合
- 予約しようとしている開始時刻が現在時刻より前の場合

### 動画
https://gyazo.com/c7c0d533ae200d186885171537fd292c

## 予約一覧表示機能
登録された当日以降の予約を一覧で表示する(すべて・担当者別)

### 動画
https://gyazo.com/1cd650fb15016c1452b556cc7c2dc7a9

## 予約詳細表示機能
登録された当日以降の予約の内容を表示する

### 動画
https://gyazo.com/6d24d506b3adc726cc2be667482aa044

## 予約情報編集機能
開始時刻が現在の時刻以降になっている予約に対して、次の情報を入力すると予約の変更ができる
- 予約日時
- メニュー(プルダウン選択)
- 担当者(プルダウン選択)
ただし、次のケースでは予約の変更ができないようバックエンドで制御している
- 変更しようとしている時間帯に担当者の予約がすでにある場合
- 変更しようとしている時間帯に他の担当者でお客様の予約がすでにある場合
- 変更しようとしている日が火曜日の場合
- 変更しようとしているメニューにより終了時刻が18:00より遅くなる場合
- 変更しようとしている開始時刻が現在の時刻より前の場合

### 動画
https://gyazo.com/d06849a14d7d5046a7d3d6b4c0ff23c0

## 予約情報削除機能
登録された現時刻以降の予約をキャンセルできる

### 動画
https://gyazo.com/1477b8ced2866ddcf0c2cf66bbd7acc6


# 実装予定の機能

## 管理者機能
管理者権限のあるユーザを作成し、管理者ユーザでサインインできる

## 予約一覧表示機能：管理者用
管理者でサインインすると、予約一覧ページにおいてすべてのお客様名が確認できる


# データベース設計

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

## ER図

### 画像
https://gyazo.com/ee0e60ee79e97230d70f8e62deaab01f


# ローカルでの動作方法

## リポジトリのクローン
- % git clone https://github.com/HIDEKAZU-YARITA/original-app-32479.git
- % cd original-app-32479
- % bundle install
- % yarn install
- % rails db:create
- % rails db:migrate
- % rails s

## 開発環境
- ruby 2.6.5
- Rails 6.0.3.4
- active_hash (3.1.0)
- devise (4.7.3, 4.7.2, 4.7.1)
- mysql2 (0.5.3)

