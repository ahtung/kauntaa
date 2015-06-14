# CounterEntity
class CounterEntity < Grape::Entity
  expose :id
  expose :name
  expose :value
  expose :increment_url
  expose :palette, using: PaletteEntity
  expose :user, using: UserEntity
end
