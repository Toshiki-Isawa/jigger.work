require 'rails_helper'

RSpec.describe "Relationships", type: :request do
  let(:end_user) { create(:end_user) }
  let(:other_user) { create(:end_user) }
  let(:active) { end_user.active_relationships.build(follower_id: other_user.id) }
  subject { active }

  before do
    sign_in end_user
  end

  describe "follower/followed methods" do
    it { should respond_to(:follower) }
    it { should respond_to(:following) }
    it "follower method return following-user" do
      expect(active.follower). to eq other_user
    end
    it "followed method return followed-user" do
      expect(active.following). to eq end_user
    end
  end

  describe 'follow/unfollow' do
    context "follow" do
      it 'フォローできる' do
        post public_end_user_relationships_path(end_user_id: other_user.id), xhr: true
        expect(response.status).to eq 200
      end
    end
    
    context "unfollow" do
      before do
        post public_end_user_relationships_path(end_user_id: other_user.id), xhr: true
      end
      it 'フォロー解除できる' do
        delete public_end_user_relationships_path(end_user_id: other_user.id), xhr: true
        expect(response.status).to eq 200
      end
    end
  end

end
