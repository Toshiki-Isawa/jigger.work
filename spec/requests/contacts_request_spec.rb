require 'rails_helper'

RSpec.describe "Contacts", type: :request do

  describe 'index' do
    context "お問い合わせページが表示される" do
      it 'リクエストは200 OKとなること' do
        get contacts_path
        expect(response.status).to eq 200
      end
    end
  end

  describe 'confirm' do
    context "内容確認ページが正しく表示される" do
      it '直接アクセスした場合はリダイレクトされる' do
        get contacts_confirm_path
        expect(response.status).to eq 301
      end
      it '内容が入っていない場合はリダイレクトされる' do
        visit contacts_path
        click_button '確認する'
        expect(page).to have_content 'お問い合わせ'
      end
      it '内容が入っている場合は次に進む' do
        visit contacts_path
        fill_in 'Email', with: 'test@example.com'
		  	fill_in 'Message', with: Faker::Lorem.characters(number:50)
        click_button '確認する'
        expect(page).to have_content 'お問い合わせ内容確認'
      end
    end
  end

  describe 'thanks' do
    context "お問い合わせが送信される" do
      it "送信後トップページへリダイレクトする" do
        visit contacts_path
        fill_in 'Email', with: 'test@example.com'
        fill_in 'Message', with: Faker::Lorem.characters(number:50)
        click_button '確認する'
        click_button '送信する'
        expect(page).to have_content 'Jigger'
      end
    end
  end

end
