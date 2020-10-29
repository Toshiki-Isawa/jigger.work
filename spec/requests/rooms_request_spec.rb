require 'rails_helper'

RSpec.describe "Rooms", type: :request do
  let(:end_user) { create(:end_user) }

  describe 'トークルーム一覧ページ' do
    context "ログインしていない場合" do
      it 'HTTP302レスポンスとともにログイン処理にリダイレクト' do
        get rooms_path
        expect(response.status).to eq 302
      end
    end
    context "ログインしている場合" do
      before do
        sign_in end_user
      end
      it 'リクエストは200 OKとなること' do
        get rooms_path
        expect(response.status).to eq 200
      end
    end
  end

end
