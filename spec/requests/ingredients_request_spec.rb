require 'rails_helper'

RSpec.describe "Ingredients", type: :request do

  describe '材料一覧ページ' do
    context "一覧ページが正しく表示される" do
      before do
        get public_ingredients_path
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
    end
  end

end
