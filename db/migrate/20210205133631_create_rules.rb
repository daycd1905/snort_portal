class CreateRules < ActiveRecord::Migration[6.0]
  def change
    create_table :snort_rules do |t|
      t.string    :action
      t.string    :protocol
      t.string    :src_address
      t.string    :src_port
      t.string    :direction
      t.string    :dest_address
      t.string    :dest_port
      t.boolean   :status, default: true
      t.jsonb     :options, default: {}
    end

    add_index :snort_rules, :action
    add_index :snort_rules, :protocol
    add_index :snort_rules, :src_address
    add_index :snort_rules, :src_port
    add_index :snort_rules, :dest_address
    add_index :snort_rules, :dest_port
    add_index :snort_rules, :status
  end
end
