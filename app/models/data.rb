require 'composite_primary_keys'

class Data < ApplicationRecord
  self.table_name = 'data'
  self.primary_keys = :cid, :sid

  belongs_to :data
end