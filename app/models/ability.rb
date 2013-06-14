class Ability
  include CanCan::Ability

  def initialize(user)
    if user.nil?
      can :read, Cocktail
      can :read, Recipe
    elsif user.admin?
      can :manage, :all
    else
      can :read, Bar, user_id: user.id
      can :create, Bottle
      can :destroy, Bottle, bar: { user_id: user.id }
      can [:read, :create, :update], Cocktail
      can :read, Recipe
      can [:create, :update], Recipe, user_id: user.id
    end
    
  end
end
