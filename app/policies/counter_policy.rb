# CounterPolicy
class CounterPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @counter = model
  end

  def index?
    current_user
  end

  def new?
    @counter.user == current_user
  end

  def add?
    current_user
  end

  def edit?
    @counter.user == current_user
  end

  def create?
    @counter.user == current_user
  end

  def show?
    @counter.user == current_user
  end

  def update?
    @counter.user == current_user
  end

  def destroy?
    @counter.user == current_user
  end
end
