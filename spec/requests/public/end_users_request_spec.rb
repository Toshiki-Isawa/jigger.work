require 'rails_helper'

RSpec.describe "EndUsers", type: :request do
  let(:end_user) { create(:end_user) }
  let(:other_user) { create(:end_user) }
  let(:cocktail) { create(:cocktail, end_user: end_user) }

  
  describe 'show/edit' do
    before do
      sign_in end_user
    end
    context "アカウント詳細画面が表示できる" do
      it '自分のアカウント' do
        get public_end_user_path(end_user)
        expect(response.status).to eq 200
      end
      it '他人のアカウント' do
        get public_end_user_path(other_user)
        expect(response.status).to eq 200
      end
    end
    context "編集画面が表示できる" do
      it '自分のアカウント' do
        get edit_public_end_user_path(end_user)
        expect(response.status).to eq 200
      end
      it '他人のアカウントにアクセスしたら自分のアカウント編集画面にリダイレクトする' do
        get edit_public_end_user_path(other_user)
        expect(response.status).to eq 200
      end
    end
  end

  describe 'guest' do
    context "ゲストログインができる" do
      it 'ログイン後トップページへリダイレクトする' do
        post guest_sign_in_path
        expect(response).to redirect_to root_path
      end
    end
  end

end
