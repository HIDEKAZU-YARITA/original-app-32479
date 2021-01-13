require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe '#create' do
    before do
      @reservation = FactoryBot.build(:reservation)
    end

    describe 'ユーザー新規登録' do
      context '新規登録がうまくいくとき' do
        it 'すべての項目が存在すれば登録できる' do
          expect(@reservation).to be_valid
        end
      end

      context '新規登録がうまくいかないとき' do
        it 'menu_idが0の場合は登録できない' do
          @reservation.menu_id = 0
          @reservation.valid?
          expect(@reservation.errors.full_messages).to include('Menu must be selected.')
        end
        it 'staff_idが0の場合は登録できない' do
          @reservation.staff_id = 0
          @reservation.valid?
          expect(@reservation.errors.full_messages).to include('Staff must be selected.')
        end
      end
    end
  end
end
