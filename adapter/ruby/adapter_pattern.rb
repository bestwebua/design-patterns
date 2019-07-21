=begin
According to the GoF, the intent of the Adapter pattern is to:

"Convert the interface of a class into another interface clients expect.
Adapter lets classes work together that couldn’t otherwise because
of incompatible interfaces".
=end

class Host
  def ping; end
end

class HostAdapter
  def initialize(host)
    @host = host
  end

  def use_tool
    @host.ping
  end
end

class Tool
  def initialize(adapter)
    @adapter = adapter
  end
  
  def use_tool
    @adapter.use_tool
  end
end

host = Host.new
host_adapter = HostAdapter.new(host)
tool = Tool.new(host_adapter)
tool.use_tool