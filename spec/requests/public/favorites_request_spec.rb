require 'rails_helper'

RSpec.describe "Favorites", type: :request do
  let(:end_user) { create(:end_user) }
  let(:cocktail) { create(:cocktail, end_user: end_user) }

  before do
    sign_in end_user
  end

  describe 'like/unlike' do
    context "like" do
      it 'お気に入り登録できる' do
        post public_cocktail_favorites_path(cocktail_id: cocktail.id), xhr: true
        expect(response.status).to eq 200
      end
    end
    
    context "unlike" do
      before do
        post public_cocktail_favorites_path(cocktail_id: cocktail.id), xhr: true
      end
      it 'お気に入り解除できる' do
        delete public_cocktail_favorites_path(cocktail_id: cocktail.id), xhr: true
        expect(response.status).to eq 200
      end
    end
  end

end
