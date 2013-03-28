class Ability
  include CanCan::Ability 
  
  def initialize(user)
	user ||= User.new                     
    if user.role? :SuperAdmin
      can :manage, :all 
    elsif user.role? :Admin      #
	    can :manage, :all
	  else
		  can :read, :all
	  end
  end
end