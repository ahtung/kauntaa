module V1
  # Counters API
  class Counters < Grape::API
    desc 'Increment counter'
    resource :users do
      segment '/:user_id' do
        get '/counters' do
          # authorize Counter, :index?
          @counters = User.find(params[:user_id]).counters.order(updated_at: :desc)
        end
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
