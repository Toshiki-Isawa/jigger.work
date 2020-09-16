class Batch::RegularUpdate
  require 'matrix'

  # cocktail-fのレシピを更新
  def self.api_cocktails
    # cocktail-fのカクテル一覧(1ページ目)を取得
    response = open("https://cocktail-f.com/api/v1/cocktails").read
    hash = JSON.parse(response)

    total_page = hash["total_pages"]
    page = 1
    save_count = 0
    total_page.times do
      response = open("https://cocktail-f.com/api/v1/cocktails?page=#{page}").read
      hash = JSON.parse(response)
      api_cocktails = hash["cocktails"]
      
      api_cocktails.each do |api_cocktail|
        if Cocktail.find_by(name: api_cocktail["cocktail_name"]).nil?
          cocktail = Cocktail.new
          cocktail.name = api_cocktail["cocktail_name"]
          cocktail.base_name = api_cocktail["base_name"]
          cocktail.technique_name = api_cocktail["technique_name"]
          cocktail.taste_name = api_cocktail["taste_name"]
          cocktail.style_name = api_cocktail["style_name"]
          cocktail.alcohol = api_cocktail["alcohol"]
          cocktail.tpo_name = api_cocktail["top_name"]
          cocktail.cocktail_desc = api_cocktail["cocktail_digest"]
          cocktail.recipe_desc = api_cocktail["recipe_desc"]
          cocktail.end_user_id = 1 # user1が投稿したものとする
          if cocktail.save
            save_count += 1
            api_cocktail["recipes"].each do |api_recipe|
              recipe = cocktail.ingredient_relations.new
              recipe.cocktail_id = cocktail.id
              recipe.ingredient_id = api_recipe["ingredient_id"]
              recipe.amount = api_recipe["amount"]
              recipe.unit = api_recipe["unit"]
              recipe.save
            end
          end
        end
      end
      page += 1
    end
    p "カクテルレシピを更新しました"
  end

  # 類似度テーブルの更新
  def self.similar_table
    # Favoriteテーブルから各カクテル毎の集団ベクトルマトリクスを作成
    cocktails = Cocktail.find(Favorite.group(:cocktail_id).pluck(:cocktail_id))
    favorite_matrix = {}
    cocktails.each do |cocktail|
      cocktail_id = Array.new(cocktails.count, 0)
      # 渡されたカクテルをお気に入り登録しているユーザーを抽出
      EndUser.find(Favorite.group(:end_user_id).where(cocktail_id: cocktail.id ).pluck(:end_user_id)).each do |user|
        # ユーザー群に対してカクテルをお気に入り登録しているか判定し、trueなら加算処理を行う
        cocktails.each_with_index do |f,index|
          if f.favorited_by?(user)
            cocktail_id[index] += 1
          end
        end
      end
      favorite_matrix.store("#{cocktail.id}", cocktail_id)
    end

    # favorite_matrixテーブルを正規化
    normalized_vectors = {}
    favorite_matrix.each do |gk, gv|
      normalized_vectors[gk] = Vector.elements(gv).normalize
    end

    # 組み合わせごとのコサイン類似度（ベクトルの内積）を出力
    normalized_vectors.keys.combination(2) do |v1k, v2k|
      # puts "cocktail_id:#{v1k}とcocktail_id:#{v2k}の類似度は#{normalized_vectors[v1k].inner_product(normalized_vectors[v2k])}"
      if similar_cocktail = Similar.find_by(cocktail1: v1k, cocktail2: v2k)
        similar_cocktail.value = normalized_vectors[v1k].inner_product(normalized_vectors[v2k])
        similar_cocktail.save
      else
        similar_cocktail = Similar.new
        similar_cocktail.cocktail1 = v1k
        similar_cocktail.cocktail2 = v2k
        similar_cocktail.value = normalized_vectors[v1k].inner_product(normalized_vectors[v2k])
        similar_cocktail.save
      end
    end
    p "類似テーブルを更新しました"
  end

end