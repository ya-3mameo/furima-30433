class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :burden
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :delivery_days


  with_options presence: true do
    validates :name
    validates :description
    validates :category
    validates :status
    validates :image
    validates :burden
    validates :prefecture
    validates :delivery_days
    validates :price, format: { with: /\A[0-9]+\z/}
  end

  with_options numericality: { other_than: 1} do
    validates :category_id
    validates :status_id
    validates :burden_id
    validates :prefecture_id
    validates :delivery_days_id
  end

  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 99999999 }

end
