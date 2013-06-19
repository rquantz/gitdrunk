require 'spec_helper'

describe RecipesController do

  describe "GET index" do
    before :each do
      @recipe = create(:recipe)
    end
    it "assigns all recipes as @recipes" do
      get :index, format: :json
      assigns(:recipes).should eq([@recipe])
    end
    
    it "returns json" do
      get :index, format: :json
      expect(response.body).to have_content([@recipe].to_json)
    end
  end

  describe "GET show" do
    before :each do
      @recipe = create(:recipe)
    end
    it "assigns the requested recipe as @recipe" do
      get :show, id: @recipe, format: :json
      assigns(:recipe).should eq(@recipe)
    end
    
    it "returns json" do
      get :show, id: @recipe, format: :json
      expect(response.body).to have_content(@recipe.to_json)
    end
  end

  context 'with user logged in' do
    before :each do
      sign_in(@user = create(:user))
    end

    describe "POST create" do
      describe "with valid params" do
        before :each do
          @cocktail = create(:cocktail)
        end
        it "creates a new Recipe" do
          expect {
            post :create, recipe: attributes_for(:recipe, cocktail_id: @cocktail.id), format: :json
          }.to change(Recipe, :count).by(1)
        end
        
        it "assigns a newly created recipe as @recipe" do
          post :create, recipe: attributes_for(:recipe, cocktail_id: @cocktail.id), format: :json
          assigns(:recipe).should be_a(Recipe)
          assigns(:recipe).should be_persisted
        end
        
        it 'creates a new Recipe that belongs to the signed in user' do
          post :create, recipe: attributes_for(:recipe, cocktail_id: @cocktail.id), format: :json
          expect(assigns(:recipe).user).to eq(@user)
        end

        it 'returns json' do
          post :create, recipe: attributes_for(:recipe, tasting_notes: 'These notes', cocktail_id: @cocktail.id), format: :json
          expect(response.body).to have_content('These notes')
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved recipe as @recipe" do
          # Trigger the behavior that occurs when invalid params are submitted
          Recipe.any_instance.stub(:save).and_return(false)
          post :create, :recipe => {  }, format: :json
          assigns(:recipe).should be_a_new(Recipe)
        end
        
        it "returns json" do
          post :create, :recipe => {  }, format: :json
          expect(response.headers["Content-Type"]).to have_content('json')
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        before :each do
          @recipe = create(:recipe, user: @user)
        end
        it "updates the requested recipe" do
          # Assuming there are no other recipes in the database, this
          # specifies that the Recipe created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          Recipe.any_instance.should_receive(:update).with({ 'tasting_notes' => 'these notes'})
          put :update, id: @recipe.to_param, recipe: { 'tasting_notes' => 'these notes' }, format: :json
        end

        it "assigns the requested recipe as @recipe" do
          put :update, id: @recipe, recipe: attributes_for(:recipe), format: :json
          assigns(:recipe).should eq(@recipe)
        end
        
        it 'returns json' do
          put :update, id: @recipe, recipe: attributes_for(:recipe), format: :json
          expect(response.body).to have_content(@recipe.to_json)
        end
      end

      describe "with invalid params" do
        it "assigns the recipe as @recipe" do
          recipe = create(:recipe)
          # Trigger the behavior that occurs when invalid params are submitted
          Recipe.any_instance.stub(:save).and_return(false)
          put :update, id: recipe, recipe: {}, format: :json
          assigns(:recipe).should eq(recipe)
        end
      end
    end

    describe "DELETE destroy" do
      before :each do
        @recipe = create(:recipe)
      end
      it "destroys the requested recipe" do
        expect {
          delete :destroy, id: @recipe, format: :json
        }.to change(Recipe, :count).by(-1)
      end
      
      it 'returns json' do
        delete :destroy, id: @recipe, format: :json
        expect(response.body).to have_content({}.to_json)
      end
    end
  end

end
