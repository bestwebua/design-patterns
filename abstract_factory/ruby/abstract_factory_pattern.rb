# The goal of Abstract Factory pattern:

# Provide an interface for creating families of related or dependent
# objects without specifying their concrete classes.

class CarService
  attr_reader :car_service_factory

  def initialize(car_service_factory)
    @car_service_factory = car_service_factory
  end

  def start_service!
    %i[new_engine_service new_wheels_service].each do |service|
      car_service_factory.public_send(:service)
    end
  end
end

class ServiceTypeFactory
  %i[target_staff car_spares].each { |method| define_method(method) }
end

class WheelsServiceFactory < ServiceTypeFactory
  def target_staff
    TireStaff.new
  end

  def car_spares
    Wheels.new
  end
end

class EngineServiceFactory < ServiceTypeFactory
  def target_staff
    GarageMechanicsStaff.new
  end

  def car_spares
    EngineParts.new
  end
end

CarService.new(WheelsServiceFactory.new).start_service!
CarService.new(EngineServiceFactory.new).start_service!
