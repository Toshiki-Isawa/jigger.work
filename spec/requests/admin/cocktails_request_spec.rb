require 'rails_helper'

RSpec.describe "Cocktails", type: :request do
  let(:admin) { create(:admin) }
  let(:end_user) { create(:end_user) }
  let(:cocktail) { create(:cocktail, end_user: end_user) }
  let(:ingredient) { create(:ingredient) }
  let(:ingredient_relation) { create(:ingredient_relation, cocktail: cocktail, ingredient: ingredient) }

  before do
    sign_in admin
  end

  describe 'カクテルレシピ一覧ページ' do
    context "一覧ページが正しく表示される" do
      before do
        get admins_cocktails_path
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
    end
  end

  describe 'カクテルレシピ詳細ページ' do
    context "詳細ページが正しく表示される" do
      before do
        get admins_cocktail_path(cocktail)
      end
      it 'リクエストは200 OKとなること' do
  			expect(response.status).to eq 200
      end
    end
  end

  describe 'destroy' do
    context "レシピを削除できる" do
      it '成功する' do
        delete admins_cocktail_path(cocktail)
      end
    end
  end

  describe 'api/similar' do
    context "apiからレシピを取得できる" do
      it 'データベースに保存される' do
        get get_api_cocktails_admins_cocktails_path
      end
    end
    context "類似テーブルの更新" do
      it 'テーブルが更新される' do
        get similar_cocktail_admins_cocktails_path
      end
    end
  end

end
