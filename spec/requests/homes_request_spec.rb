require 'rails_helper'

RSpec.describe "Homes", type: :request do

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

end
