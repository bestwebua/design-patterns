# The goal of Abstract Factory pattern: provide an interface for creating
# families of related or dependent objects without specifying their
# concrete classes.

# You should use the Abstract Factory pattern whenever you have a system
# which should remain independent of how its objects are created, composed,
# and represented.

# You should also use the Abstract Factory pattern in cases where related
# families of objects are created and designed to be used together and you
# need to enforce that design.

# The Abstract Factory pattern may also be used to reveal the interfaces of
# families of objects, but conceal their implementations.

class CarService
  attr_reader :car_service_factory

  def initialize(car_service_factory)
    @car_service_factory = car_service_factory
  end

  def start_service!
    %i[new_target_staff new_car_spares].each do |service|
      car_service_factory.public_send(service)
    end
  end
end

class ServiceTypeFactory
  %i[new_target_staff new_car_spares].each { |method| define_method(method) {} }
end

%i[TireStaff Wheels GarageMechanicsStaff EngineParts].each do |class_name|
  Object.const_set(class_name, Class.new)
end

class WheelsServiceFactory < ServiceTypeFactory
  def new_target_staff
    TireStaff.new
  end

  def new_car_spares
    Wheels.new
  end
end

class EngineServiceFactory < ServiceTypeFactory
  def new_target_staff
    GarageMechanicsStaff.new
  end

  def new_car_spares
    EngineParts.new
  end
end

CarService.new(WheelsServiceFactory.new).start_service!
CarService.new(EngineServiceFactory.new).start_service!
