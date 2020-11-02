require 'rails_helper'

RSpec.describe "Searchs", type: :request do
  let(:end_user) { create(:end_user) }
  let(:cocktail) { create(:cocktail, end_user: end_user) }
  let(:ingredient) { create(:ingredient) }
  let(:ingredient_relation) { create(:ingredient_relation, cocktail: cocktail, ingredient: ingredient) }

  describe 'レシピ検索' do
    context "検索結果が表示される" do
      it '材料名で検索した場合' do
        get search_path(:content => ingredient.name)
        expect(response.status).to eq 200
      end
      it 'カクテル名で検索した場合' do
        get search_path(:content => cocktail.name)
        expect(response.status).to eq 200
      end
    end
  end

end