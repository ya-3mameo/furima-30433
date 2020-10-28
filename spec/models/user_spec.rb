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
        expect(@user.errors.full_messages).to include('ニックネームを入力してください')
      end
      it 'emailが空では登録できないこと' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールを入力してください')
      end
      it 'emailに@がないと登録できないこと' do
        @user.email = 'abcgmail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end
      it '重複したemailが存在する場合登録できないこと' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end

      it 'passwordが空では登録できないこと' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを入力してください')
      end
      it 'passwordが5文字以下であれば登録できない' do
        @user.password = '1asdf'
        @user.password_confirmation = '1asdf'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'パスワードは、半角英数字混合（半角英語のみ）は登録できない' do
        @user.password = 'asdfgh'
        @user.password_confirmation = 'asdfgh'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it 'passwordとpassword_confirmationが不一致では登録できないこと' do
        @user.password = '1asdf'
        @user.password_confirmation = '1asdd'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
      end

      it 'family_nameが空では登録できないこと' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前（姓）を入力してください', 'お名前（姓）は不正な値です')
      end
      it 'first_nameが空では登録できないこと' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前（名）を入力してください')
      end
      it 'family_nameが全角（漢字・ひらがな・カタカナ）でない場合は登録できない' do
        @user.family_name = 'suzuki'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前（姓）は不正な値です')
      end
      it 'first_nameが全角（漢字・ひらがな・カタカナ）でない場合は登録できない' do
        @user.first_name = 'tarou'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前（名）は不正な値です')
      end

      it 'family_name_furiganaが空では登録できないこと' do
        @user.family_name_furigana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('カナ（姓）を入力してください')
      end

      it 'first_name_furiganaが空では登録できないこと' do
        @user.first_name_furigana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('カナ（名）を入力してください')
      end

      it 'family_name_furiganaは、全角（カタカナ）でない場合は登録できない' do
        @user.family_name_furigana = 'すずき'
        @user.valid?
        expect(@user.errors.full_messages).to include('カナ（姓）は不正な値です')
      end

      it 'first_name_furiganaは、全角（カタカナ）でない場合は登録できない' do
        @user.first_name_furigana = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include('カナ（名）は不正な値です')
      end

      it 'birthday(生年月日)が空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('生年月日を入力してください')
      end
    end
  end
end
