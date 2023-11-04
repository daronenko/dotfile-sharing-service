class Dotfile < ApplicationRecord
  has_one_attached :file
  belongs_to :user

  def self.ransackable_attributes(auth_object = nil)
    ["title", "description", "config_type", "username"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end
end
