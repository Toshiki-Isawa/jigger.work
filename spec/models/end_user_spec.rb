require 'rails_helper'

RSpec.describe EndUser, type: :model do

  describe 'ユーザー登録' do
    it "name、email、birth_date、passwordとpassword_confirmationが存在すれば登録できること" do
      end_user = build(:end_user)
      expect(end_user).to be_valid
    end
  end

  describe 'バリデーション' do
    it "emailがない場合は登録できないこと" do
      end_user = build(:end_user, email: "")
      end_user.valid?
      expect(end_user.errors[:email]).to include("を入力してください")
    end
  end

end