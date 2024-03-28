class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    %w[name created_at updated_at] # 将你希望允许搜索的属性名称添加到数组中
  end
  def self.ransackable_associations(auth_object = nil)
    ['products'] # 将你希望允许搜索的关联名称添加到数组中
  end
end
