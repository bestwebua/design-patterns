=begin
According to the GoF, the intent of the Decorator pattern is to:

"Attach additional responsibilities to an object dynamically.
Decorators provide a flexible alternative to subclassing for
extending functionality."
=end


User = Struct.new(:first_name, :last_name, :email)

UserDecorator = Class.new(SimpleDelegator) do
  def full_name
    "#{first_name} #{last_name}"
  end
end

user = UserDecorator.new(User.new('First Name', 'Last Name', 'email@email.com'))
user.full_name
