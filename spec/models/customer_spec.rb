require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe '#create' do
    before do
      @customer = FactoryBot.build(:customer)
    end

    describe 'ユーザー新規登録' do
      context '新規登録がうまくいくとき' do
        it 'すべての項目が存在すれば登録できる' do
          expect(@customer).to be_valid
        end
      end

      context '新規登録がうまくいかないとき' do
        it 'emailが空では登録できない' do
          @customer.email = ''
          @customer.valid?
          expect(@customer.errors.full_messages).to include("Email can't be blank")
        end
        it 'emailに@がないと登録できない' do
          @customer.email = 'ab'
          @customer.valid?
          expect(@customer.errors.full_messages).to include('Email is invalid')
        end
        it 'emailの最初に@があると登録できない' do
          @customer.email = '@ab'
          @customer.valid?
          expect(@customer.errors.full_messages).to include('Email is invalid')
        end
        it 'emailの最後に@があると登録できない' do
          @customer.email = 'ab@'
          @customer.valid?
          expect(@customer.errors.full_messages).to include('Email is invalid')
        end
        it '重複したemailが存在する場合登録できない' do
          @customer.save
          another_customer = FactoryBot.build(:customer)
          another_customer.email = @customer.email
          another_customer.valid?
          expect(another_customer.errors.full_messages).to include('Email has already been taken')
        end
        it 'passwordが空では登録できない' do
          @customer.password = ''
          @customer.password_confirmation = ''
          @customer.valid?
          expect(@customer.errors.full_messages).to include("Password can't be blank")
        end
        it 'passwordが数字だけでは登録できない' do
          @customer.password = '123456'
          @customer.password_confirmation = '123456'
          @customer.valid?
          expect(@customer.errors.full_messages).to include('Password is invalid.')
        end
        it 'passwordが英字だけでは登録できない' do
          @customer.password = 'AbCdEf'
          @customer.password_confirmation = 'AbCdEf'
          @customer.valid?
          expect(@customer.errors.full_messages).to include('Password is invalid.')
        end
        it 'passwordが5文字以下であれば登録できない' do
          @customer.password = 'Abc12'
          @customer.password_confirmation = 'Abc12'
          @customer.valid?
          expect(@customer.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
        end
        it 'passwordが存在してもpassword_confirmationが空では登録できない' do
          @customer.password = 'Abc123'
          @customer.password_confirmation = ''
          @customer.valid?
          expect(@customer.errors.full_messages).to include("Password confirmation doesn't match Password")
        end
        it 'passwordとpassword_confirmationが一致していないと登録できない' do
          @customer.password = 'Abc123'
          @customer.password_confirmation = 'Def456'
          @customer.valid?
          expect(@customer.errors.full_messages).to include("Password confirmation doesn't match Password")
        end
        it '姓が空では登録できない' do
          @customer.last_name = ''
          @customer.valid?
          expect(@customer.errors.full_messages).to include("Last name can't be blank")
        end
        it '姓が半角文字では登録できない' do
          @customer.last_name = 'yamada'
          @customer.valid?
          expect(@customer.errors.full_messages).to include('Last name is invalid. Input full-width characters.')
        end
        it '名が空では登録できない' do
          @customer.first_name = ''
          @customer.valid?
          expect(@customer.errors.full_messages).to include("First name can't be blank")
        end
        it '名が半角文字では登録できない' do
          @customer.first_name = 'taro'
          @customer.valid?
          expect(@customer.errors.full_messages).to include('First name is invalid. Input full-width characters.')
        end
        it '姓(カナ)が空では登録できない' do
          @customer.last_name_kana = ''
          @customer.valid?
          expect(@customer.errors.full_messages).to include("Last name kana can't be blank")
        end
        it '姓(カナ)が半角文字では登録できない' do
          @customer.last_name_kana = 'yamada'
          @customer.valid?
          expect(@customer.errors.full_messages).to include('Last name kana is invalid. Input full-width katakana characters.')
        end
        it '姓(カナ)が漢字では登録できない' do
          @customer.last_name_kana = '山田'
          @customer.valid?
          expect(@customer.errors.full_messages).to include('Last name kana is invalid. Input full-width katakana characters.')
        end
        it '姓(カナ)がかなでは登録できない' do
          @customer.last_name_kana = 'やまだ'
          @customer.valid?
          expect(@customer.errors.full_messages).to include('Last name kana is invalid. Input full-width katakana characters.')
        end
        it '名(カナ)が空では登録できない' do
          @customer.first_name_kana = ''
          @customer.valid?
          expect(@customer.errors.full_messages).to include("First name kana can't be blank")
        end
        it '名(カナ)が半角文字では登録できない' do
          @customer.first_name_kana = 'taro'
          @customer.valid?
          expect(@customer.errors.full_messages).to include('First name kana is invalid. Input full-width katakana characters.')
        end
        it '名(カナ)が漢字では登録できない' do
          @customer.first_name_kana = '太郎'
          @customer.valid?
          expect(@customer.errors.full_messages).to include('First name kana is invalid. Input full-width katakana characters.')
        end
        it '名(カナ)がカナでは登録できない' do
          @customer.first_name_kana = 'たろう'
          @customer.valid?
          expect(@customer.errors.full_messages).to include('First name kana is invalid. Input full-width katakana characters.')
        end
        it '電話番号が入力されていないと保存できないこと' do
          @customer.phone_number = nil
          @customer.valid?
          expect(@customer.errors.full_messages).to include("Phone number can't be blank")
        end

        it '電話番号にハイフンが入力されていると保存できないこと' do
          @customer.phone_number = '03-3333-3333'
          @customer.valid?
          expect(@customer.errors.full_messages).to include('Phone number is invalid.')
        end

        it '電話番号が9桁以下で入力されていると保存できないこと' do
          @customer.phone_number = '012345678'
          @customer.valid?
          expect(@customer.errors.full_messages).to include('Phone number is invalid.')
        end

        it '電話番号が12桁以上で入力されていると保存できないこと' do
          @customer.phone_number = '012345678901'
          @customer.valid?
          expect(@customer.errors.full_messages).to include('Phone number is invalid.')
        end

        it '電話番号に全角文字が入力されていると保存できないこと' do
          @customer.phone_number = '０１２３４５６７８９'
          @customer.valid?
          expect(@customer.errors.full_messages).to include('Phone number is invalid.')
        end
      end
    end
  end
end
