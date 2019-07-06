# The goal of Abstract Factory pattern:

# Provide an interface for creating families of related or dependent
# objects without specifying their concrete classes.

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
