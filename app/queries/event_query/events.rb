module EventQuery
  class Events
    attr_reader :options

    def initialize(options= {})
      @options = options
    end

    def execute_events
      ActiveRecord::Base.connection.execute("#{event_query}").to_a
    end

    def execute_events_count
      ActiveRecord::Base.connection.execute("#{event_query_count_total}").to_a.first["count"]
    end

    private

    def event_query
      "
        SELECT event.sid,event.cid,event.timestamp, data.data_payload
        ,(SELECT sig_class_name FROM sig_class WHERE sig_class_id = (SELECT sig_class_id FROM signature WHERE sig_id = event.signature))
        ,(SELECT signature.sig_name FROM signature WHERE signature.sig_id = event.signature)  
        ,(
          SELECT 
          CASE WHEN signature.sig_priority <= 2 THEN 'High'
              WHEN signature.sig_priority < 2 and signature.sig_priority < 4 THEN 'Medium'
              ELSE 'Low'
          END as \"priority\"
          FROM signature
          WHERE signature.sig_id = event.signature
        )
        ,(
          SELECT 
          CASE WHEN iphdr.ip_proto=6 THEN 'tcp'
              WHEN iphdr.ip_proto=17 THEN 'udp'
              ELSE 'icmp'
          END as \"protocol\"
        )
        ,iphdr.ip_src
        ,(
          SELECT 
          CASE WHEN iphdr.ip_proto=6 THEN (select tcp_sport from tcphdr where tcphdr.sid = event.sid and tcphdr.cid = event.cid)
              WHEN iphdr.ip_proto=17 THEN (select udp_sport from udphdr where udphdr.sid = event.sid and udphdr.cid = event.cid)
              ELSE 0
          END as \"sport\"
        )
        ,iphdr.ip_dst
        ,(
          SELECT 
          CASE WHEN iphdr.ip_proto=6 THEN (select tcp_dport from tcphdr where tcphdr.sid = event.sid and tcphdr.cid = event.cid)
              WHEN iphdr.ip_proto=17 THEN (select udp_dport from udphdr where udphdr.sid = event.sid and udphdr.cid = event.cid)
              ELSE 0
          END as \"dport\"
        )
        FROM event
        INNER JOIN iphdr on iphdr.sid = event.sid and iphdr.cid = event.cid
        LEFT JOIN data on data.sid = data.sid AND data.cid = event.cid
        ORDER BY event.timestamp DESC
        LIMIT #{options[:per_page]} OFFSET #{options[:offset]}
      "
    end

    def event_query_count_total
      "
        SELECT count(*)
        FROM event
        INNER JOIN iphdr on iphdr.sid = event.sid and iphdr.cid = event.cid
        LEFT JOIN data on data.sid = data.sid AND data.cid = event.cid
      "
    end
  end
end