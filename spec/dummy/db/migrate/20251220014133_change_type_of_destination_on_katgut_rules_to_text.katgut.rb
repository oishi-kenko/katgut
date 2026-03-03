# This migration comes from katgut (originally 20161219050212)
class ChangeTypeOfDestinationOnKatgutRulesToText < ActiveRecord::Migration[4.2]
  def self.up
    change_column :katgut_rules, :destination, :text, null: false
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
