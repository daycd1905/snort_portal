class ChangeOptionTypeInRule < ActiveRecord::Migration[6.0]
  def change
	  change_column :snort_rules, :options, :text
  end
end
