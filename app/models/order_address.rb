class OrderAddress
  include ActiveModel::Model
  attr_accessor :token, :user_id, :item_id, :postal_number, :prefecture_id, :city, :house_number, :building, :phone_number

  with_options presence: true do
    validates :postal_number, format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }
    validates :prefecture_id
    validates :city
    validates :house_number
    validates :phone_number, format: { with: /\A0[5789]0\d{4}\d{4}\z/ }
  end

  validates :prefecture_id, numericality: { other_than: 1 }

  def save
    user = User.create
    item = Item.create
    order = Order.create(user_id: user.id, item_id: item.id)
    Address.creare(postal_number: postal_number, prefecture_id: prefecture_id, city: city, house_number: house_number,  building: building, phone_number: phone_number)
  end


end
