module V1
  # Counters API
  class Counters < Grape::API
    resource :counters do
      desc 'List all Counters'
      get do
        Counter.all
      end
    end

    resource :counters do
      desc 'Increment counter'
      params do
        requires :id, type: Integer, desc: 'Counter id.'
      end
      route_param :id do
        get do
          counter = Counter.find(params[:id])
          counter.increment
        end
      end
    end
  end
end
