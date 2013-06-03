class Ability
  include CanCan::Ability 
  
  def initialize(user)
  # Always performed
    can :access, :ckeditor   # needed to access Ckeditor filebrowser

    # Performed checks for actions:
    can [:read, :create, :destroy], Ckeditor::Picture
    can [:read, :create, :destroy], Ckeditor::AttachmentFile
    can :read, Page
    can [:create], User
              # allow everyone to read everything
              # add ability to create comments
    user ||= User.new   
    if user.role? :SuperAdmin
      can :manage, :all 
    elsif user.role? :Admin  
      can :read, Supermodel
      can :manage, [Announcement, Event, Image, Journal, Message, Page, Role, User, Program]
    elsif user.role? :Staff
      can :manage, [Announcement, Event, Image, Message, Page]
      can [:show, :delete], Journal
      can [:create, :index, :show], Role
      can [:create, :index, :show, :update], User
    elsif user.role? :"Regional Director"
      can [:create, :index, :show, :update], [Announcement, Event, Image, Message]
    elsif user.role? :Coordinator
      can [:index, :show], [Announcement, Event, Image, Message, Page, Role]
      can :create, Image
    elsif user.role? :Moderator
      ## nothing as of yet
    elsif user.role? :Student
      can [:index, :show], [Announcement, Event, Image, Message, Page, Role]
      can :create, Image
    elsif user.role? :"Host-Family"
      ## nothing as of yet
    elsif user.role? :Student
      can [:index, :show], [Announcement, Event, Image, Message, Page, Role]
    end
  end
end