# A clear example of the Singleton pattern
# According to the GoF, the intent of the Singleton pattern is to:
# 'Ensure a class only has one instance, and provide a global point
# of access to it'

# Not thread safe singleton

class Singleton
  private_class_method :new

  def self.instance
    @instance ||= new
  end

  attr_accessor :data

  def initialize
    @data = :data
  end
end

# Thread safe singleton

class Singleton
  private_class_method :new

  def self.instance
    @instance ||= new
  end

  def initialize
    @data = :data
    @mutex = Mutex.new
  end

  def data
    with_mutex { @data }
  end

  def data=(arg)
    with_mutex { @data = arg }
  end

  private

  def with_mutex
    @mutex.synchronize { yield }
  end
end

p Singleton.instance
Singleton.instance.data = :new_data
p Singleton.instance
