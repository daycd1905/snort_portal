require 'composite_primary_keys'
class Classification < ApplicationRecord
  self.table_name = 'sig_class'
  self.primary_keys = :sig_class_id

  has_one :log_signature, :foreign_key => :sig_class_id
end