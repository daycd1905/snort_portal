class ChangeDefaultValueOptionRules < ActiveRecord::Migration[6.0]
  def change
    change_column_default :snort_rules, :options, "()"
  end
end
