require 'composite_primary_keys'

class Tcphdr < ApplicationRecord
  self.table_name = 'tcphdr'
  self.primary_keys = :cid, :sid

  belongs_to :event
end