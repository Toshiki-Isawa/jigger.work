require 'rails_helper'

RSpec.describe "Homes", type: :request do
  let(:admin) { create(:admin) }
  let(:end_user) { create(:end_user) }

  describe 'トップページ' do
    context "ルートパスでトップページが正しく表示される" do
      before do
        get root_path
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
    end
  end

  describe '用語一覧ページ' do
    context "用語一覧ページが正しく表示される" do
      before do
        get  public_terms_path
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
    end
  end

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
