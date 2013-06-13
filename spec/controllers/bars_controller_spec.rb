require 'spec_helper'

describe BarsController do
  context 'user is logged in' do
    before :each do
      @user = create(:user)
      sign_in :user, @user
    end
    describe 'GET #show' do
      it 'gets the bar of the current_user' do
        get :show
        expect(assigns(:bar)).to eq(@user.bar)
      end
      it 'render the show view' do
        get :show
        expect(response).to render_template(:show)
      end
    end
  end
  context 'guest user' do
    describe 'GET #show' do
      it 'redirects to the login url' do
        get :show
        expect(response).to redirect_to new_user_session_url
      end
    end
  end
end
