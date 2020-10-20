FactoryBot.define do
  factory :item do
    name            { '商品名です' }
    description     { '説明です' }
    category_id     { '2' }
    status_id       { '2' }
    burden_id       { '2' }
    prefecture_id   { '2' }
    delivery_day_id { '2' }
    price           { '400' }
    association :user

    after(:build) do |i|
      i.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
