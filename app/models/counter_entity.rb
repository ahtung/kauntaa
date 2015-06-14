# CounterEntity
class CounterEntity < Grape::Entity
  expose :id
  expose :name
  expose :value
  expose :palette, using: PaletteEntity
  expose :user, using: UserEntity
end
