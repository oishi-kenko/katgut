class AddRedirectionCountToKatgutRules < ActiveRecord::Migration
  def change
    add_column :katgut_rules, :redirection_count, :integer, default: 0, null: false
  end
end
