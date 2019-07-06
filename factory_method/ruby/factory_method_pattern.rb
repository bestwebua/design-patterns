# The goal of Factory Method Pattern is define an interface for
# creating an object, but let subclasses decide which class to instantiate.
# Factory Method lets a class defer instantiation to subclasses.

class Team
  def initialize(backend_developers: 0, frontend_developers: 0)
    @backend_developers = [new_team_member(developer_profile: :backend)] * backend_developers
    @frontend_developers = [new_team_member(developer_profile: :frontend)] * frontend_developers
  end

  def new_team_member(*)
    raise "abstract method #{__method__} must be defined"
  end
end

%i[RubyDeveloper JavaDeveloper JsDeveloper].each do |class_name|
  Object.const_set(class_name, Class.new)
end

class RubyProjectTeam < Team
  def new_team_member(developer_profile:)
    case developer_profile
    when :backend then RubyDeveloper.new
    when :frontend then JsDeveloper.new
    end
  end
end

class JavaProjectTeam < Team
  def new_team_member(developer_profile:)
    case developer_profile
    when :backend then JavaDeveloper.new
    when :frontend then JsDeveloper.new
    end
  end
end

RubyProjectTeam.new(backend_developers: 2, frontend_developers: 2)
JavaProjectTeam.new(backend_developers: 2, frontend_developers: 2)
