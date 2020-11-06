require 'rails_helper'

RSpec.describe "Ingredients", type: :request do
  let(:ingredient) { create(:ingredient) }
  let(:admin) { create(:admin) }

  describe 'admin' do
    before do
      sign_in admin
    end
    context "index" do
      before do
        visit admins_ingredients_path
      end
      it 'リクエストは200 OKとなること' do
        get public_ingredients_path
        expect(response.status).to eq 200
      end
      it '材料名が表示される' do
  			expect(page).to have_content ingredient.name
      end
      it '材料種別が表示される' do
        Ingredient.type_names.keys.each do |type_name|
          expect(page).to have_content type_name
        end
      end
    end
    context "search" do
      it '材料検索結果が表示される' do
        Ingredient.type_names.keys.each do |type_name|
          post search_admins_ingredients_path(:name => type_name)
          expect(response.status).to eq 200
        end
      end
    end

    context "create/update/destroy" do
      before do
        visit admins_ingredients_path
        fill_in 'ingredient_name', with: 'test'
        fill_in 'ingredient_alcohol', with: 40
        click_button '追加'
      end
      it '材料追加に失敗する' do
        click_button '追加'
      end
      it '材料編集に成功する' do
        click_button '変更'
      end
      it '材料削除に成功する' do
        click_link '削除'
      end
    end
  end

end
