# A clear example of the Singleton pattern
# According to the GoF, the intent of the Singleton pattern is to:
# 'Ensure a class only has one instance, and provide a global point
# of access to it'

class Singleton
  def self.instance
    @instance ||= new
  end

  private_class_method :new
end

Singleton.instance
