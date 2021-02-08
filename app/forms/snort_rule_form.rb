class SnortRuleForm < SnortRule
  validates :action, presence: true
  validates :protocol, presence: true
  validates :src_address, presence: true
  validates :src_port, presence: true
  validates :direction, presence: true
  validates :dest_address, presence: true
  validates :dest_port, presence: true
end