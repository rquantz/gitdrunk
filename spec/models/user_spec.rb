require 'spec_helper'
require 'cancan/matchers'

describe User do
  it 'is valid with valid attributes' do
    expect(build(:user)).to be_valid
  end
  it 'is not valid without a username' do
    expect(build(:user, username: nil)).not_to be_valid
  end
  
  describe 'create' do
    before :each do
      @user = create(:user)
    end
    it 'creates a new bar when the user is created' do
      expect(@user.bar).not_to be_nil
    end
    it 'persists the bar' do
      expect(@user.bar).to be_persisted
    end
  end

  describe 'admin?' do
    it 'returns true if user role is admin' do
      expect(create(:user, role: 'admin')).to be_admin
    end
    it 'returns false if user role is not admin' do
      expect(create(:user, role: 'user')).not_to be_admin
    end
  end

  describe 'abilities' do
    subject { ability }
    let(:ability) { Ability.new(user) }
    let(:user) { @user = nil }
    
    context 'when user is not signed in' do
      it 'cannot read bars' do
        expect(subject).not_to be_able_to(:read, create(:bar))
      end
      it 'cannot create bottles' do
        expect(subject).not_to be_able_to(:create, Bottle)
      end
      it 'cannot destroy bottles' do
        expect(subject).not_to be_able_to(:destroy, create(:bottle))
      end
      it 'can read cocktails' do
        expect(subject).to be_able_to(:read, create(:cocktail))
      end
      it 'cannot do anything else to cocktails' do
        expect(subject).not_to be_able_to(:create, Cocktail)
        expect(subject).not_to be_able_to(:update, create(:cocktail))
        expect(subject).not_to be_able_to(:destroy, create(:cocktail))
      end
      it 'can read recipes' do
        expect(subject).to be_able_to(:read, create(:recipe))
      end
    end
    
    context 'when user is signed in' do
      let(:user) { @user = create(:user) }

      # Bars
      it 'cannot read random bars' do
        expect(subject).not_to be_able_to(:read, create(:bar))
      end
      it 'can read its own bar' do
        expect(subject).to be_able_to(:read, create(:bar, user: @user))
      end

      # Bottles
      it 'can create bottles' do
        expect(subject).to be_able_to(:create, Bottle)
      end
      it 'can destroy bottles in its bar' do
        expect(subject).to be_able_to(:destroy, create(:bottle, bar: @user.bar))
      end
      it 'cannot destroy bottle not in its bar' do
        expect(subject).not_to be_able_to(:destroy, create(:bottle))
      end

      # Cocktails
      it 'can read cocktails' do
        expect(subject).to be_able_to(:read, create(:cocktail))
      end
      it 'can create and update cocktails' do
        expect(subject).to be_able_to(:create, Cocktail)
        expect(subject).to be_able_to(:update, create(:cocktail))
      end
      it 'cannot destroy cocktails' do
        expect(subject).not_to be_able_to(:destroy, create(:cocktail))
      end
      
      # Ingredients
      it 'can read any ingredient'
      it 'can create, update, or destroy an ingredient for a recipe it owns'
      it 'cannot create, update, or destroy an ingredient for a recipe it does not own'
      # Recipes
      it 'can read any recipe' do
        expect(subject).to be_able_to(:read, build(:recipe))
      end
      it 'can create and update recipes that belong to them' do
        expect(subject).to be_able_to(:create, build(:recipe, user: @user))
        expect(subject).to be_able_to(:update, build(:recipe, user: @user))
      end
      it 'cannot create or update recipes that do not belong to them' do
        expect(subject).not_to be_able_to(:create, build(:recipe))
        expect(subject).not_to be_able_to(:update, build(:recipe))
      end
      
    end
    
    context 'when user is admin' do
      let(:user) { @user = create(:admin_user) }

      it 'can manage bars' do
        expect(subject).to be_able_to(:manage, create(:bar))
      end
      it 'can manage bottles' do
        expect(subject).to be_able_to(:manage, create(:bottle))
      end
      it 'can manage cocktails' do
        expect(subject).to be_able_to(:manage, create(:cocktail))
      end
    end
  end
end
