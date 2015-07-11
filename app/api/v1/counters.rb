module V1
  # Counters API
  class Counters < Grape::API
    desc "Lists users' counters"
    resource :users do
      segment '/:user_id' do
        resources :counters do
          desc "Create Counter"
          params do
            requires :counter, type: Hash do
              requires :name, type: String, desc: "Name"
              optional :value, type: Integer, desc: "Value"
              requires :palette_id, type: Integer, desc: "Palette"
            end
          end
          post do
            authenticate!
            Counter.create!(params[:counter].merge(user: current_user).to_h)
          end

          desc 'List counters'
          get do
            authenticate!
            present current_user.counters.includes(:user).includes(:palette), with: CounterEntity
          end

          desc 'Increment counter'
          params do
            requires :id, type: Integer, desc: 'Counter id.'
          end
          route_param :id do
            get :increment do
              authenticate!
              counter = current_user.counters.includes(:user).includes(:palette).find(params[:id])
              counter.increment
              present counter, with: CounterEntity
            end
          end

          desc 'Read counter'
          params do
            requires :id, type: Integer, desc: 'Counter id.'
          end
          route_param :id do
            get do
              authenticate!
              counter = current_user.counters.includes(:user).includes(:palette).find(params[:id])
              present counter, with: CounterEntity
            end
          end
        end
      end
    end

    helpers do
      def authenticate!
        error!('Unauthorized. Invalid or expired token.', 401) unless current_user
      end

      def current_user
        if env['warden'].authenticate!
          @current_user = env['warden'].user
        else
          false
        end
      end
    end
  end
end
