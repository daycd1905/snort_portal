require 'composite_primary_keys'

class Udphdr < ApplicationRecord
  self.table_name = 'udphdr'
  self.primary_keys = :cid, :sid

  belongs_to :event
end