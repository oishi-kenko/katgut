# This migration comes from katgut (originally 20160704065128)
class CreateKatgutRules < ActiveRecord::Migration[4.2]
  def change
    create_table :katgut_rules do |t|
      t.string :source, null: false
      t.string :destination, null: false
      t.boolean :active, null: false, default: false

      t.timestamps null: false
    end

    add_index :katgut_rules, :source, unique: true, name: 'idx_katgut_source'
  end
end
