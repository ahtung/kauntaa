# User
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :counters, dependent: :destroy
  before_create :build_counter

  def self.find_for_google_oauth2(access_token, _ = nil)
    data = access_token.info
    user = User.find_by(email: data['email'])
    unless user
      user = User.create(
        email: data['email'],
        password: Devise.friendly_token[0, 20]
      )
    end
    user
  end

  private

  def build_counter
    counters.build(palette: Palette.all.sample) if counters.empty?
  end
end
