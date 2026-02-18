class CreateTables < ActiveRecord::Migration[7.2]
  def change
    create_table :services, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.string :code, null: false, index: { unique: true }
      t.string :name, null: false
      t.text :description
      t.decimal :base_price, precision: 10, scale: 2, null: false, default: 0
      t.timestamps
    end

    create_table :products, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.string :sku, null: false, index: { unique: true }
      t.string :name, null: false
      t.text :description
      t.integer :stock_quantity, null: false, default: 0
      t.decimal :base_price, precision: 10, scale: 2, null: false, default: 0
      t.timestamps
    end
  end
end
