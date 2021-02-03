require 'composite_primary_keys'

class Event < ApplicationRecord
  self.table_name = 'event'
  self.primary_keys = :cid, :sid

  has_one :iphdr, :foreign_key => [:cid, :sid]
  has_one :icmphdr, :foreign_key => [:cid, :sid]
  has_one :tcphdr, :foreign_key => [:cid, :sid]
  has_one :udphdr, :foreign_key => [:cid, :sid]

  belongs_to :log_signature, :primary_key => :sig_id , :foreign_key => :signature
end