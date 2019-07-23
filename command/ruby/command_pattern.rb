=begin
According to the GoF, the intent of the Command pattern is to:

"Encapsulate a request as an object, thereby letting you parameterize
clients with different requests, queue or log requests, and support
undoable operations."
=end

class Command
  attr_reader :description

  def initialize(description)
    @description = description
  end

  def execute; end
end

class DeleteFile < Command
  def initialize(path)
    super("Delete file: #{path}")
    @path = path
  end

  def execute
    "Delete action with #{@path}"
  end
end

p DeleteFile.new('file').execute
