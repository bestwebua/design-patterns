# A clear example of the Singleton pattern
# According to the GoF, the intent of the Singleton pattern is to:
# 'Ensure a class only has one instance, and provide a global point
# of access to it'

# Not thread safe singleton

# class Singleton
#   private_class_method :new

#   def self.instance
#     @instance ||= new
#   end

#   attr_accessor :data

#   def initialize
#     @data = :data
#   end
# end

# Thread safe singleton with safe attr_accessor

class Class
  def thread_safe_attr_accessor(*attrs, with:)
    attrs.each do |attr|
      instance_var = :"@#{attr}"
      define_method(attr) { send(with) { instance_variable_get(instance_var) } }
      define_method("#{attr}=") { |arg| send(with) { instance_variable_set(instance_var, arg) } }
    end
  end
end

class Singleton
  private_class_method :new

  def self.instance
    @instance ||= new
  end

  def initialize
    @data = :data
    @lock = Mutex.new
  end

  thread_safe_attr_accessor :data, with: :synchronize

  private

  def synchronize
    @lock.synchronize { yield }
  end
end

p Singleton.instance
Singleton.instance.data = :new_data
p Singleton.instance
