class ContactPage < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

def self.ransackable_attributes(auth_object = nil)
  %w[title content created_at updated_at]
end
end
