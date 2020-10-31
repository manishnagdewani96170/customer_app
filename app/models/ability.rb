# frozen_string_literal: true

class Ability
  include CanCan::Ability

  attr_reader :user, :role

  def initialize(user)
    return if user.blank?

    @user = user
    @role = user.role
    define_abilities
  end

  private

  def define_abilities
    case role.role_code
    when branch_manager  then define_branch_manager_abilities
    when customer       then define_customer_abilities
    else # no additional abilities for the role type
    end
  end

  def define_branch_manager_abilities
    can :manage, User, User.role_based_user('customer')
  end

  def define_customer_abilities
    can :read, [User], :user_id => user.id
  end  
  
end
