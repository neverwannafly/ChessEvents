require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  let!(:old_user) { create(:user, email: 'shubham@chessevents.com') }

  describe "#create" do
    context "when username is missing" do
      subject do
        post :create, params: {
          registration: {
            name: 'Shubham',
            email: 'newshubham@chessevents.com',
            password: 'password'
          }
        }
      end

      it 'should return UNPROCESSIBLE ENTITY' do
        res = subject
        expect(res.status).to eq(422)
      end

      it 'should return correct error' do
        res = JSON.parse(subject.body)
        expect(res).to eq({"error"=>{"username"=>["can't be blank", "Invalid username"]}})
      end
    end

    context "when email is missing" do
      subject do
        post :create, params: {
          registration: {
            name: 'Shubham',
            password: 'password',
            username: 'alwayswannaly'
          }
        }
      end

      it 'should return UNPROCESSIBLE ENTITY' do
        res = subject
        expect(res.status).to eq(422)
      end

      it 'should return correct error' do
        res = JSON.parse(subject.body)
        expect(res).to eq({"error"=>{"email"=>["can't be blank", "Invalid email"]}})
      end
    end

    context "when email is already taken" do
      subject do
        post :create, params: {
          registration: {
            name: 'Shubham',
            password: 'password',
            email: 'shubham@chessevents.com',
            username: 'alwayswannaly'
          }
        }
      end

      it 'should return UNPROCESSIBLE ENTITY' do
        res = subject
        expect(res.status).to eq(422)
      end

      it 'should return correct error' do
        res = JSON.parse(subject.body)
        expect(res).to eq({"error"=>{"email"=>["has already been taken"]}})
      end
    end

    context "when user username/email is not already taken" do
      subject do
        post :create, params: {
          registration: {
            email: 'newshubham@chessevents.com',
            name: 'Shubham Anand',
            password: 'password',
            username: 'alwayswannaly'
          }
        }
      end

      it 'should return OK' do
        res = subject
        expect(res.status).to eq(200)
      end

      it 'should log the user in' do
        subject
        new_user = User.find_by_email('newshubham@chessevents.com')
        expect(current_user.id).to eq(new_user.id)
      end

      it 'should return correct user data' do
        res = JSON.parse(subject.body)
        new_user = User.find_by_email('newshubham@chessevents.com')
        expect(res).to eq(UserSerializer.new(new_user).as_json)
      end
    end
  end
end
