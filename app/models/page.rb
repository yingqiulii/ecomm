# app/models/page.rb
class Page < ApplicationRecord
  validates :title, presence: true

  validates :content, presence: true, length: { maximum: 255 }
  validates :created_at, presence: true
  validates :updated_at, presence: true
  def self.ransackable_attributes(auth_object = nil)
    %w[title content created_at updated_at]
  end
end

