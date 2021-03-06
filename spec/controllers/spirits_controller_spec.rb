require 'spec_helper'

describe SpiritsController do
  before :each do
    sign_in :user, create(:user)
  end

  describe 'guest user access' do
    before :each do
      sign_out :user
    end
    it 'GET #show requires login' do
      get :show, id: create(:spirit)
      expect(response).to redirect_to new_user_session_url
    end
    it 'GET #edit requires login' do
      get :edit, id: create(:spirit)
      expect(response).to redirect_to new_user_session_url
    end
    it 'GET #index requires login' do
      get :index
      expect(response).to redirect_to new_user_session_url
    end
    it 'POST #create requires login' do
      post :create, spirit: attributes_for(:spirit)
      expect(response).to redirect_to new_user_session_url
    end
    it 'PUT #update requires login' do
      spirit = create(:spirit)
      put :update, id: spirit, spirit: attributes_for(:spirit, name: 'New Name')
      expect(response).to redirect_to new_user_session_url
    end
  end

  describe 'GET #index' do
    it 'populates an array of spirits' do
      spirit = create(:spirit)
      get :index
      expect(assigns(:spirits)).to match_array [spirit]
    end
    it 'renders the :index view' do
      get :index
      expect(response).to render_template :index
    end
    context 'when brand_only is true' do
      it 'gets only the brand spirits' do
        create(:child_spirit)
        get :index, brand_only: 'true'
        expect(assigns(:spirits)).to eq(Spirit.brand_only)
      end
    end
  end
  
  describe 'GET #show' do
    before :each do
      @spirit = create(:spirit)
    end
    it 'finds the spirit' do
      get :show, id: @spirit
      expect(assigns(:spirit)).to eq @spirit
    end
    it 'renders the :show view' do
      get :show, id: @spirit
      expect(response).to render_template :show
    end
  end
  
  describe 'GET #edit' do
    before :each do
      @spirit = create(:spirit)
    end
    it 'locates the requested spirit' do
      get :edit, id: @spirit
      expect(assigns(:spirit)).to eq @spirit
    end
    it 'renders the :edit view' do
      get :edit, id: @spirit
      expect(response).to render_template :edit
    end
  end
  
  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new spirit to the database' do
        expect do
          post :create, spirit: attributes_for(:spirit)
        end.to change(Spirit, :count).by(1)
      end
      it 'redirects to spirits index' do
        post :create, spirit: attributes_for(:spirit)
        expect(response).to redirect_to spirits_url
      end
    end
    
    context 'with invalid attributes' do
      it 'does not save the new spirit' do
        expect do
          post :create, spirit: attributes_for(:invalid_spirit)
        end.not_to change(Spirit, :count)
      end
      it 're-renders the new page' do
        post :create, spirit: attributes_for(:invalid_spirit)
        expect(response).to render_template :new
      end
    end
    
    context 'json output' do
      it 'renders a json string' do
        post :create, spirit: attributes_for(:spirit), format: :json
        expect(response.headers['Content-Type']).to have_content('application/json')
      end
      it 'returns content' do
        post :create, spirit: attributes_for(:spirit), format: :json
        expect(response.body).to have_content Spirit.last.to_json
      end
    end
  end

  describe 'PUT #update' do
    before :each do
      @spirit = create(:spirit)
    end
    it 'locates the requested spirit' do
      put :update, id: @spirit, spirit: attributes_for(:spirit)
      expect(assigns(:spirit)).to eq @spirit
    end
    context 'valid attributes' do
      it "changes the spirit's attributes" do
        put :update, id: @spirit, spirit: attributes_for(:spirit, name: 'Not Whiskey')
        @spirit.reload
        expect(@spirit.name).to eq 'Not Whiskey'
      end
      it 'redirects to the spirits#index' do
        put :update, id: @spirit, spirit: attributes_for(:spirit)
        expect(response).to redirect_to spirits_url
      end
    end
    context 'invalid attributes' do
      it "does not change the spirit's attributes" do
        put :update, id: @spirit, spirit: attributes_for(:invalid_spirit)
        @spirit.reload
        expect(@spirit.name).not_to be_nil
      end
      it 'rerenders spirits#edit' do
        put :update, id: @spirit, spirit: attributes_for(:invalid_spirit)
        expect(response).to render_template :edit
      end
    end
    context 'json output' do
      it 'returns a json string' do
        put :update, id: @spirit, spirit: attributes_for(:spirit), format: :json
        expect(response.headers['Content-Type']).to have_content 'application/json'
      end
      it 'returns content' do
        put :update, id: @spirit, spirit: attributes_for(:spirit), format: :json
        expect(response.body).to have_content @spirit.to_json
      end
    end
  end
  
  describe 'DELETE #destroy' do
    before :each do
      @spirit = create(:spirit)
    end
    it 'deletes the message' do
      expect {
        delete :destroy, id: @spirit
      }.to change(Spirit, :count).by(-1)
    end
    it 'redirects to spirits#index' do
      delete :destroy, id: @spirit
      expect(response).to redirect_to spirits_url
    end
  end
end

