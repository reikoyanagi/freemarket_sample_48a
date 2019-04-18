class CreateDeliveries < ActiveRecord::Migration[5.2]
  def change
    create_table :deliveries do |t|
      t.string       :postage, null: false
      t.string       :shipping, null: false
      t.string       :region, null: false
      t.string       :shipping_date, null: false
      t.references   :item, foreign_key: true
      t.timestamps
    end
  end
end
