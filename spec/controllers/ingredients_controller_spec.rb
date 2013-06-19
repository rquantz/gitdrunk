require 'spec_helper'

describe IngredientsController do

  let(:valid_params) { attributes_for(:ingredient, recipe_id: create(:recipe, user: @user).id, spirit_id: create(:spirit).id) }
  let(:invalid_params) { attributes_for(:invalid_ingredient, recipe_id: create(:recipe, user: @user).id) }
  let(:user) { @user = create(:user) }
  
  context 'with user logged in' do
    before :each do
      sign_in user
    end
    
    describe 'POST #create' do

      context 'with valid params' do
        it 'creates a new ingredient and saves it to the database' do
          expect {
            post :create, ingredient: valid_params, format: :json
          }.to change(Ingredient, :count).by(1)
        end
        it 'returns the new ingredient as json' do
          post :create, ingredient: valid_params, format: :json
          expect(response.body).to have_content valid_params[:recipe_id]
        end
      end

      context 'with invalid params' do
        it 'does not save the new ingredient' do
          expect {
            post :create, ingredient: invalid_params, format: :json
          }.not_to change(Ingredient, :count)
        end
        it 'returns an error code' do
          post :create, ingredient: invalid_params, format: :json
          expect(response.response_code).to eq 422
        end
        it 'returns the list of errors' do
          post :create, ingredient: invalid_params, format: :json
          expect(response.body).to have_content 'errors'
        end
      end
    end
    
    describe 'PUT #update' do
      before :each do
        @ingredient = create(:ingredient)
      end
      context 'with valid params' do
        it 'updates the ingredient' do
          Ingredient.any_instance.should_receive(:update).with({"amount" => nil})
          put :update, id: @ingredient, ingredient: {"amount" => nil}, format: :json
        end
        it 'returns status 200' do
          put :update, id: @ingredient, ingredient: valid_params, format: :json
          expect(response.response_code).to eq 200
        end
      end
      context 'with invalid params' do
        it 'returns status 422' do
          put :update, id: @ingredient, ingredient: invalid_params, format: :json
          expect(response.response_code).to eq 422
        end
      end
    end
    
    describe 'DELETE #destroy' do
      before :each do
        @ingredient = create(:ingredient)
      end
      it 'deletes the ingredient' do
        expect {
          delete :destroy, id: @ingredient, format: :json
        }.to change(Ingredient, :count).by(-1)
      end
    end
  end
end
