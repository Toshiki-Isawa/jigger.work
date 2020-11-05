require 'rails_helper'

RSpec.describe "EndUsers", type: :request do
  let(:admin) { create(:admin) }
  let(:end_user) { create(:end_user) }
  let(:cocktail) { create(:cocktail, end_user: end_user) }

  before do
    sign_in admin
  end
  
  describe '表示確認' do
    context "index" do
      it '200 OK' do
        get admins_end_users_path
        expect(response.status).to eq 200
      end
      it 'ページタイトルが表示される' do
        visit admins_end_users_path
        expect(page).to have_content 'ユーザー一覧'
      end
    end
    context "show" do
      it '200 OK' do
        get admins_end_user_path(end_user)
        expect(response.status).to eq 200
      end
      it 'ユーザー名が表示される' do
        visit admins_end_user_path(end_user)
        expect(page).to have_content end_user.name
      end
    end
  end
  
  describe 'アカウント管理' do
    context "withdraw/unfreeze" do
      it 'アカウントの凍結/解除ができる' do
        patch withdraw_admins_end_user_path(end_user.id)
        patch unfreeze_admins_end_user_path(end_user.id)
      end
    end
  end

end
