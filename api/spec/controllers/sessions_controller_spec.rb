require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let!(:user) { create(:user, username: 'alwayswannaly') }

  describe "#create" do
    context "when user exists" do
      subject do
        post :create, params: { username: 'alwayswannaly', password: 'password' }
      end

      it 'should return OK' do
        res = subject
        expect(res.status).to eq(200)
      end

      it 'should return correct user data' do
        res = JSON.parse(subject.body)
        expect(res).to eq(UserSerializer.new(user).as_json)
      end

      it 'should log the user in' do
        subject
        expect(current_user.id).to eq(user.id)
      end
    end

    context "when user doesnt exist" do
      subject do
        post :create, params: { username: 'neverwannafly', password: 'password' }
      end

      it 'should return NOT FOUND' do
        res = subject
        expect(res.status).to eq(404)
      end

      it 'should return correct error' do
        res = JSON.parse(subject.body)
        expect(res).to eq({"error"=>"Email Password combination is incorrect"})
      end

      it 'should not log the user in' do
        subject
        expect(current_user).to be(nil)
      end
    end
  end

  describe "#destroy" do
    subject do
      delete :destroy
    end

    context "when user is logged in" do
      before do
        sign_in(user)
      end

      it 'should log the user out' do
        subject
        expect(current_user).to be(nil)
      end
    end

    context "when user is loggedout" do
      it 'should return FORBIDDEN' do
        res = subject
        expect(res.status).to eq(403)
      end
    end
  end
end
