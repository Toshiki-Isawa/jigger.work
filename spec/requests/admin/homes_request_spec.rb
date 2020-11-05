require 'rails_helper'

RSpec.describe "Homes", type: :request do
  let(:admin) { create(:admin) }
  let(:end_user) { create(:end_user) }

  describe 'admin' do
    context "トップページが表示される" do
      it '管理者でログインしている場合' do
        sign_in admin
        get admins_top_path
        expect(response.status).to eq 200
      end
      it '管理者でログインしていない場合' do
        get admins_top_path
        expect(response.status).to eq 302
      end
    end
  end

end
