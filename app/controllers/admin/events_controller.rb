module Admin
  class EventsController < BaseController
    before_action :set_authorization

    def index
      @events = paging Event.includes(:iphdr, :icmphdr, :tcphdr, :data).all.order(timestamp: :desc)
    end

    def detail
      sid, cid = normalize_event_id

      @event = Event.includes(:data).where(sid: sid, cid: cid).last
      @data  = @event.data

      @messages = EventService::DecodeEventDetail.new(@data.data_payload).execute
    end

    def set_authorization
      begin  
        case action_name
        when 'edit', 'update'
          authorize!(:update, @user || User)
        when 'new', 'create'
          authorize!(:create, @user || User)
        when 'destroy'
          authorize!(:destroy, @user || User)
        else
          authorize!(:read, @user || User)
        end
      rescue => e
        render(
        html: "<script>alert('You do not have permission to access that action!')</script>".html_safe,
          layout: 'admin'
        )
      end
    end

    private

    def event_detail_params
      params.require(:id)
    end

    def normalize_event_id
      id = event_detail_params.split(',')

      sid = id.last.to_i, cid = id.first.to_i
    end
  end
end