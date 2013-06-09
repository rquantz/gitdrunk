require 'spec_helper'

describe BottlesController do
  let(:valid_params) { attributes_for(:bottle, spirit_id: create(:spirit).id) }
  let(:invalid_params) { attributes_for(:bottle, spirit_id: nil) }

  before :each do
    @user = create(:user)
    sign_in @user
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new bottle' do
        expect {
          post :create, bottle: valid_params, format: :json
        }.to change(Bottle, :count).by(1)
      end
      it 'creates a bottle in the current bar' do
        post :create, bottle: valid_params, format: :json
        expect(@user.bar.bottles).to include(Bottle.last) 
      end
      it 'invokes #save on the current bar' do
        Bar.any_instance.should_receive(:save)
        post :create, bottle: valid_params, format: :json
      end
      it 'assign newly created bottle to @bottle' do
        post :create, bottle: valid_params, format: :json
        expect(assigns(:bottle)).to be_a(Bottle)
        expect(assigns(:bottle)).to be_persisted
      end
      it 'returns json' do
        post :create, bottle: valid_params, format: :json
        expect(response.headers['Content-Type']).to have_content('json')
      end
    end
    context 'with invalid params' do
      it 'assigns a new bottle' do
        post :create, bottle: invalid_params, format: :json
        expect(assigns(:bottle)).to be_a_new(Bottle)
      end
      it 'returns an error code' do
        post :create, bottle: invalid_params, format: :json
        expect(response.response_code).to eq(422)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when current user owns bottle' do
      before :each do
        @parent_spirit = create(:spirit)
        @child_spirit = create(:spirit, parent: @parent_spirit)
        @parent_bottle = create(:bottle, spirit: @parent_spirit, bar: @user.bar)
        @child_bottle = create(:bottle, spirit: @child_spirit, bar: @user.bar)
      end
      it 'destroys the bottle' do
        expect {
          delete :destroy, id: @child_bottle, format: :json
        }.to change(Bottle, :count).by(-2)
      end
      it 'removes its parents from the bar' do
        expect(@user.bar.bottles).to include(@parent_bottle)
        delete :destroy, id: @child_bottle, format: :json
        expect(@user.bar.bottles).not_to include(@parent_bottle)
      end
    end
    context 'when current user does not own bottle' do
      before :each do
        @bottle = create(:bottle, bar: create(:bar))
        @user.bar.spirits << @bottle.spirit
      end
      it 'does not destroy the bottle' do
        expect {
          delete :destroy, id: @bottle, format: :json
        }.not_to change(Bottle, :count)
      end
    end
  end
end

