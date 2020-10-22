FactoryBot.define do
  factory :order_address do
    postal_number { '123-4567' }
    prefecture_id { 3 }
    city          { '名古屋市' }
    house_number  { '1-1' }
    building      { '名古屋ハイツ' }
    phone_number  { '08012345678' }
  end
end
