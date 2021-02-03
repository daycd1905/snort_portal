require 'composite_primary_keys'

class Iphdr < ApplicationRecord
  self.table_name = 'iphdr'
  self.primary_keys = :cid, :sid
  
  belongs_to :event
end