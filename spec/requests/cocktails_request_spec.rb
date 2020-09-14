require 'rails_helper'

RSpec.describe "Cocktails", type: :request do

  describe 'カクテルレシピ一覧ページ' do
    context "一覧ページが正しく表示される" do
      before do
        get public_cocktails_path
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
    end
  end

  describe 'カクテルレシピ詳細ページ' do
    let(:end_user) { create(:end_user) }
    let(:cocktail) { create(:cocktail, end_user: end_user) }

    context "詳細ページが正しく表示される" do
      before do
        get public_cocktail_path(cocktail)
      end
      it 'リクエストは200 OKとなること' do
  			expect(response.status).to eq 200
      end
      it 'レシピ名が表示される' do
        visit public_cocktail_path(cocktail)
  			expect(page).to have_content cocktail.name
      end
    end
  end

  describe 'レシピランキングページ' do
    context "ランキングページが正しく表示される" do
      before do
        get ranking_public_cocktails_path
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
    end
  end

end
