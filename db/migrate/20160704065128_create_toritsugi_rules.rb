class CreateToritsugiRules < ActiveRecord::Migration
  def change
    create_table :toritsugi_rules do |t|
      t.string :source, null: false
      t.string :destination, null: false
      t.boolean :active, null: false, default: false

      t.timestamps null: false
    end

    add_index :toritsugi_rules, :source, unique: true, name: 'idx_toritsugi_source'
  end
end
