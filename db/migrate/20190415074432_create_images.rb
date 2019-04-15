class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.references    :item, foreigh_key: true
      t.string        :item_image, null: false
      t.timestamps
    end
  end
end
