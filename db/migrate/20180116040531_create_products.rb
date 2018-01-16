class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.references  :user,        index: true, foreign_key: true
      t.string      :name,        null: false
      t.string      :description, null: false
      t.float       :price,       null: false
      t.references  :category,    index: true, foreign_key: true
      t.string      :image
      t.timestamps
    end
  end
end
