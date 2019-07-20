# According to GoF and their great book “Design Patterns: Elements of
# Reusable Object-Oriented Software”, builder pattern:

# Separate the construction of a complex object from its representation
# so that the same construction process can create different representations.

User = Struct.new(:name, :email)

class UserBuilder
  def self.build
    user = User.new
    yield(user)
    user
  end
end

new_user = UserBuilder.build do |user|
  user.name = :user_name
  user.email = 'user@email.com'
end

p new_user
