module V1
  # Counters API
  class Counters < Grape::API
    desc "Lists users' counters"
    resource :users do
      segment '/:user_id' do
        get '/counters' do
          # authorize Counter, :index?
          if params[:user_id].to_i > 0
            present User.find(params[:user_id]).counters.includes(:user).includes(:palette), with: CounterEntity
          end
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
