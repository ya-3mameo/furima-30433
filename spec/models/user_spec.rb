require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it '必須項目が存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordが半角英数字混合かつ6文字以上であれば登録できる' do
        @user.password = '1asdfg'
        @user.password_confirmation = '1asdfg'
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it 'nicknameが空では登録できないこと' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できないこと' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'emailに@がないと登録できないこと' do
        @user.email = 'abcgmail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it '重複したemailが存在する場合登録できないこと' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'passwordが空では登録できないこと' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが5文字以下であれば登録できない' do
        @user.password = '1asdf'
        @user.password_confirmation = '1asdf'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'パスワードは、半角英数字混合（半角英語のみ）は登録できない' do
        @user.password = 'asdfgh'
        @user.password_confirmation = 'asdfgh'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'passwordとpassword_confirmationが不一致では登録できないこと' do
        @user.password = '1asdf'
        @user.password_confirmation = '1asdd'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'family_nameが空では登録できないこと' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank", 'Family name is invalid')
      end
      it 'first_nameが空では登録できないこと' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank", 'First name is invalid')
      end
      it 'family_nameが全角（漢字・ひらがな・カタカナ）でない場合は登録できない' do
        @user.family_name = 'suzuki'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name is invalid')
      end
      it 'first_nameが全角（漢字・ひらがな・カタカナ）でない場合は登録できない' do
        @user.first_name = 'tarou'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end

      it 'family_name_furiganaが空では登録できないこと' do
        @user.family_name_furigana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name furigana can't be blank", 'Family name furigana is invalid')
      end

      it 'first_name_furiganaが空では登録できないこと' do
        @user.first_name_furigana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name furigana can't be blank", 'First name furigana is invalid')
      end

      it 'family_name_furiganaは、全角（カタカナ）でない場合は登録できない' do
        @user.family_name_furigana = 'すずき'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name furigana is invalid')
      end

      it 'first_name_furiganaは、全角（カタカナ）でない場合は登録できない' do
        @user.first_name_furigana = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name furigana is invalid')
      end

      it 'birthday(生年月日)が空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
