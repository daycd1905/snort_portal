require 'composite_primary_keys'

class Icmphdr < ApplicationRecord
  self.table_name = 'icmphdr'
  self.primary_keys = :cid, :sid

  belongs_to :event
end