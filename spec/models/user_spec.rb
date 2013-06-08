require 'spec_helper'

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
end
