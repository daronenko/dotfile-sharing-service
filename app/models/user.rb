class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         authentication_keys: [:login]

  validates :username, presence: true, uniqueness: true

  has_many :dotfiles

  attr_accessor :login

  def login
    @login || self.username || self.email
  end

  private

  def self.find_for_database_authentication(warden_condition)
    conditions = warden_condition.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where([
        "lower(username) = :value OR lower(email) = :value", { value: login.downcase }
      ]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end
end
