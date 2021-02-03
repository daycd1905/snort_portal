require 'composite_primary_keys'

class LogSignature < ApplicationRecord
  self.table_name = 'signature'
  self.primary_key = :sig_id

  has_many :event, :foreign_key => :signature

  belongs_to :classification, :foreign_key => :sig_class_id
end