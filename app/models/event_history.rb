class EventHistory
  attr_reader :sid,
              :cid,
              :sig_class_name,
              :sig_name,
              :priority,
              :protocol,
              :ip_src,
              :sport,
              :ip_dst,
              :dport,
              :data_payload,
              :timestamp

  def initialize(params)
    @sid            = params["sid"]
    @cid            = params["cid"]
    @sig_class_name = params["sig_class_name"]
    @sig_name       = params["sig_name"]
    @priority       = params["priority"]
    @protocol       = params["protocol"]
    @ip_src         = [params["ip_src"]].pack('N').unpack('CCCC').join('.')
    @sport          = params["sport"]
    @ip_dst         = [params["ip_dst"]].pack('N').unpack('CCCC').join('.')
    @dport          = params["dport"]
    @data_payload   = params["data_payload"]
    @timestamp      = params["timestamp"]
  end
end