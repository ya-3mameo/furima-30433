require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '配送先入力の保存' do
    before do
      @order_address = FactoryBot.build(:order_address)
    end

    context '保存できる場合' do
      it '必須項目が存在していれば保存できる' do
        expect(@order_address).to be_valid
      end
      
      it 'buildingは空でも保存できる' do
        @order_address.building = nil
        expect(@order_address).to be_valid
      end
    end

    context '保存できない場合' do
      it 'postal_numberが空では保存できない' do
        @order_address.postal_number = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal number can't be blank")
      end
      it 'postal_numberに半角のハイフンを含んでいないときは保存できない' do
        @order_address.postal_number = '123ー4567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal number is invalid')
      end

      it 'prefectureを選択していないときは保存できない' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Prefecture must be other than 1')
      end

      it 'cityが空では保存できない' do
        @order_address.city = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end

      it 'house_numberが空では保存できない' do
        @order_address.house_number = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("House number can't be blank")
      end

      it 'phone_numberが空では保存できない' do
        @order_address.phone_number = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが12桁以上で保存できない' do
        @order_address.phone_number = '090123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is invalid')
      end
      it 'phone_numberがハイフンがあると保存できない' do
        @order_address.phone_number = '090-1234-5678'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is invalid')
      end
      it 'phone_numberが全角数字で保存できない' do
        @order_address.phone_number = '０９０１２３４５６７８'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is invalid')
      end

      it 'tokenが空では保存できない' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
