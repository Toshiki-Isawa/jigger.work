require 'rails_helper'

RSpec.describe "Cocktails", type: :request do
  let(:end_user) { create(:end_user) }
  let(:cocktail) { create(:cocktail, end_user: end_user) }
  let(:ingredient) { create(:ingredient) }
  let(:ingredient_relation) { create(:ingredient_relation, cocktail: cocktail, ingredient: ingredient) }

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
      it '投稿者名が表示される' do
        visit public_cocktail_path(cocktail)
  			expect(page).to have_content cocktail.end_user.name
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

  describe 'レシピ検索' do
    context "検索結果が表示される" do
      it 'ベースネームで検索できる' do
        post search_public_cocktails_path(:name => "ジン", :search_key => "base")
        expect(response.status).to eq 200
      end
      it 'アルコール度数(25%以上)で検索できる' do
        post search_public_cocktails_path(:name => "strong", :search_key => "alcohol")
        expect(response.status).to eq 200
      end
      it 'アルコール度数(10%~25%)で検索できる' do
        post search_public_cocktails_path(:name => "normal", :search_key => "alcohol")
        expect(response.status).to eq 200
      end
      it 'アルコール度数(10%以下)で検索できる' do
        post search_public_cocktails_path(:name => "weak", :search_key => "alcohol")
        expect(response.status).to eq 200
      end
      it 'アルコール度数(ノンアルコール)で検索できる' do
        post search_public_cocktails_path(:name => "none", :search_key => "alcohol")
        expect(response.status).to eq 200
      end
      it 'テクニックで検索できる' do
        Cocktail.technique_names.keys.each do |technique_name|
          post search_public_cocktails_path(:name => technique_name, :search_key => "technique")
          expect(response.status).to eq 200
        end
      end
      it 'テイストで検索できる' do
        Cocktail.taste_names.keys.each do |taste_name|
          post search_public_cocktails_path(:name => taste_name, :search_key => "taste")
          expect(response.status).to eq 200
        end
      end
      it 'スタイルで検索できる' do
        Cocktail.style_names.keys.each do |style_name|
          post search_public_cocktails_path(:name => style_name, :search_key => "style")
          expect(response.status).to eq 200
        end
      end
      it 'TPOで検索できる' do
        Cocktail.tpo_names.keys.each do |tpo_name|
          post search_public_cocktails_path(:name => tpo_name, :search_key => "tpo")
          expect(response.status).to eq 200
        end
      end
      it '材料で検索できる' do
          post search_public_cocktails_path(:name => ingredient.name, :search_key => "ingredient")
          expect(response.status).to eq 200
      end
    end
  end

  describe '新規登録ページの表示' do
    context "ログインしていない場合" do
      it 'HTTP302レスポンスとともにログイン処理にリダイレクト' do
        get new_public_cocktail_path
        expect(response.status).to eq 302
      end
    end
    context "ログインしている場合" do
      before do
        sign_in end_user
      end
      it 'リクエストは200 OKとなること' do
        get new_public_cocktail_path
        expect(response.status).to eq 200
      end
    end
  end

  describe '新規登録' do
    context "登録に成功する" do
      before do
        sign_in end_user
      end
      it 'データベースに保存される' do
        # expect {
        #   post :create,
        #   cocktail: cocktail,
        #   ingredient_relation: ingredient_relation,
        #   ingredient: ingredient
        # }.to change( Cocktail, :count ).by(1).and change( Ingredient_relation, :count ).by(1).and change( ingredient, :count ).by(1)
        
        # params = { ingredient_relations_attributes: [FactoryBot.attributes_for(:ingredient_relation)] }
        # post public_cocktails_path, params: {
        #   cocktail: cocktail
        # }
        # expect(response.status).to eq 200
      end
      it '正しいビューに遷移する' do
      end
    end
  end

end
