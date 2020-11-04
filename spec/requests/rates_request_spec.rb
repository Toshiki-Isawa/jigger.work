require 'rails_helper'

RSpec.describe "Rates", type: :request do
  let(:end_user) { create(:end_user) }
  let(:cocktail) { create(:cocktail, end_user: end_user) }
  let(:rate) { create(:rate, end_user: end_user, cocktail: cocktail) }
  let(:rate_params) { {rate: Faker::Number.within(range: 0.0..5.0), comment: '評価', cocktail_id: cocktail.id, end_user_id: end_user.id} }

  before do
    sign_in end_user
  end

  describe 'Rate' do
    context "評価投稿作成" do
      before do
        visit public_cocktail_path(cocktail)
      end
      it '評価フォームが表示される' do
        expect(page).to have_content '評価'
      end
      it 'create rates' do
        # page.all('img')[4].click
        # (all(".form-control")[2]).set("created")
        # click_button '評価する'
        # expect(response.status).to have_http_status(:ok)
      end
    end
    
    context "削除" do
      before do
        visit public_cocktail_path(cocktail)
      end
      it '削除ボタンが表示される' do
        expect(page).to have_content '削除'
      end
      it 'delete rate' do
        delete public_cocktail_rate_path(id: rate.id, cocktail_id: rate.cocktail_id), xhr: true
        expect(response.status).to eq 200
      end
    end
  end

end
