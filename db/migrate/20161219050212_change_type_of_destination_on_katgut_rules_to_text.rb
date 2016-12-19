class ChangeTypeOfDestinationOnKatgutRulesToText < ActiveRecord::Migration
  def self.up
    change_column :katgut_rules, :destination, :text, null: false
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
