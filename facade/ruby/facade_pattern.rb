=begin
According to the GoF, the intent of the Facade pattern is to:

"Provide a unified interface to a set of interfaces in a subsystem.
Facade defines a higher-level interface that makes the subsystem
easier to use."
=end

module MyIO
  %w[Read Write Delete].each do |class_name|
    self.const_set(class_name,
      Class.new do
        define_singleton_method(class_name.downcase) { |file_path| "#{__method__}: #{file_path}" }
      end
    )
  end

  class FileUtils
    %w[read write delete].each do |method|
      define_singleton_method(method) { |arg| MyIO.const_get(method.capitalize).public_send(method, arg) }
    end
  end
end

p MyIO::FileUtils.read(:file)
p MyIO::FileUtils.write(:file)
p MyIO::FileUtils.delete(:file)
