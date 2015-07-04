# API
class API < Grape::API
  prefix 'api'
  version 'v1', using: :path
  mount V1::Authentication
  mount V1::Counters
end
