require 'spec_helper'

describe SpiritsController do
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
        put :update, id: @spirit, spirit: attributes_for(:spirit, name: nil)
        @spirit.reload
        expect(@spirit.name).not_to be_nil
      end
      it 'rerenders spirits#edit' do
        put :update, id: @spirit, spirit: attributes_for(:spirit, name: nil)
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
end

