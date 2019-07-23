=begin
According to the GoF, the intent of the Chain of Responsibility pattern is to:

"Avoid coupling the sender of a request to its receiver by giving more than one
object a chance to handle the request. Chain the receiving objects and pass the
request along the chain until an object handles it."
=end

class RegistrationController; end
class ProfileController; end
class LogsController; end

class User
  attr_reader :role

  def initialize(role)
    @role = role
  end
end

class Policy
  attr_reader :successor

  def initialize(successor=nil)
    @successor = successor
  end

  def check_access(controller, user)
    case
    when policy_matches_controller?(controller) then return process_checking_access(user)
    when successor then successor.check_access(controller, user)
    else raise_no_policy(controller)
    end
  end

  def raise_no_policy(controller)
    raise "No policy found for #{controller}"
  end

  def process_checking_access
    raise 'not implemented'
  end

  private

  def policy_matches_controller?(controller)
    controller.to_s == self.class.to_s.sub('Policy', '')
  end
end

class RegistrationControllerPolicy < Policy
  def process_checking_access(user)
    user.role.eql?(:guest)
  end
end

class ProfileControllerPolicy < Policy
  def process_checking_access(user)
    %i[user admin].include?(user.role)
  end
end

class LogsControllerPolicy < Policy
  def process_checking_access(user)
    user.role.eql?(:admin)
  end
end

user = User.new(:user)
policy = LogsControllerPolicy.new(ProfileControllerPolicy.new(RegistrationControllerPolicy.new))

p policy.check_access(ProfileController, user)
