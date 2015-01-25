class CounterPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @counter = model
  end

  def create?
    @counter.user == @current_user
  end

  def show?
    @counter.user == @current_user
  end

  def update?
    @counter.user == @current_user
  end

  def destroy?
    @counter.user == @current_user
  end
end