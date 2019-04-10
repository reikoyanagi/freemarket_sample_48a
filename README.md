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
|saler_id|integer|null: false|
|buyer_id|integer|
|status_id|integer|
|brand|string|
|size|string|

## Association
- belongs_to :user
- has_many :images
- has_one :delivery
- has_many :categories
- has_many :like
- has_many :comment

## imagesテーブル
|column|Type|options|
|------|----|-------|
|item_id|integer|foreign_key: true|
|item_image|integer|null: false|

## Association
- belongs_to :item

## deliveryテーブル
|column|Type|options|
|------|----|-------|
|postage|string|null: false|
|shipping|string|null: false|
|region|string|null: false|
|shipping_date|string|null: false|
|item_id|integer|foreign_key: true|

## Association
- belongs_to :item

## categoriesテーブル
|column|Type|options|
|------|----|-------|
|name|integer|null: false|
|item_id|integer|null: false, foreign_key: true|

## Association
- belongs_to :item
- has_ancestry


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
|birth_date|data|null: false|
|avator|text|

## Association
- has_many :items
- has_one :address
- has_one :credit_card
- has_many :sns_credentials
- has_many :like
- has_many :comment

## addressテーブル
|column|Type|options|
|------|----|-------|
|phone_number|integer|null: false, unique: true|
|post_code|integer|null: false|
|prefecture_id|integer|null: false|
|city|string|null: false|
|block|string|null: false|
|building|string|
|user_id|integer|foreign_key: true|

## Association
- belongs_to :user

## credit_cardsテーブル
|column|Type|options|
|------|----|-------|
|token_id|integer|
|user_id|integer|foreign_key: true|

## Association
- belongs_to :user

## Sns_credentialsテーブル
|column|Type|options|
|------|----|-------|
|provider|string|null: false, unique: true|
|uid|string|null: false|
|user_id|integer|null: false, foreign_key: true|

## Association
- belongs_to :user


## Likesテーブル
|column|Type|options|
|------|----|-------|
|item_id|integer|foreign_key: true|
|user_id|integer|foreign_key: true|

## Association
- belongs_to :item
- belongs_to :user

## Commentsテーブル
|column|Type|options|
|------|----|-------|
|text|text|null: false|
|item_id|integer|null: false, foreign_key: true|
|user_id|integer|null: false, foreign_key: true|

## Association
- belongs_to :item
- belongs_to :user








