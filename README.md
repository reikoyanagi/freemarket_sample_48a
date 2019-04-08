# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## itemsテーブル
|column|Type|options|
|------|----|-------|
|name|string|null: false, index:true|
|user_id|integer|foreign_key: true|
|condition|text|null: false|
|price|integer|null: false|
|detail|text|null: false|
|postage|integer|null: false|
|shipping|string|null: false|
|region|string|null: false|
|shipping_date|string|null: false|
|saler_id|integer|null: false|
|buyer_id|integer|
|status_id|integer|
|brand|string|
|size|string|

## Association
- belongs_to :user
- has_many :images

## usersテーブル
|column|Type|options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false, unique: true|
|password|string|null: false|
|last_name|string|null: false|
|first_name|string|null: false|
|last_name_kana|string|null: false|
|first_name_kana|string|null: false|
|birth_year|integer|null: false|
|birth_month|integer|null: false|
|birth_day|integer|null: false|
|phone_number|integer|null: false, unique: true|
|post_code|integer|null: false|
|prefecture_id|integer|
|city|string|
|block|string|
|building|string|
|avator|text|
|token_id|integer|

## Association
- has_many :items

## imagesテーブル
|column|Type|options|
|------|----|-------|
|items_id|integer|foreign_key: true|
|item_image|integer|null: false|

## Association
- belongs_to :item
