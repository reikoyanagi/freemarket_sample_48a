class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string         :name, null: false, index: true
      t.references     :user, foreign_key: true
      t.string         :text, null: false
      t.integer        :price, null: false
      t.text           :detail, null: true
      t.integer        :status_id
      t.string         :brand
      t.string         :size
      t.timestamps
    end
  end
end
