module V1
  # Authentication API
  class Authentication < Grape::API
    helpers do
      def authenticated
        if warden.authenticated?
          return true
        else
          error!('401 Unauthorized', 401)
        end
      end

      def current_user
        warden.user
      end
    end
  end
end
