require 'rails_helper'

RSpec.describe "OmniauthCallback", type: :request do

  describe 'Omniauth' do

    context "click_response" do
      before do
        visit new_end_user_session_path
      end
      it 'facebook' do
        find('.fa-facebook-square').click
        expect(current_path).to eq root_path
      end
      it 'google' do
        find('.fa-google-plus').click
        expect(current_path).to eq root_path
      end
      it 'twitter' do
        find('.fa-twitter-square').click
        expect(current_path).to eq root_path
      end
    end

  end

end
