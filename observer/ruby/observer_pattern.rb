=begin
According to the GoF, the intent of the Observer pattern is to:

Define a one-to-many dependency between objects so that when
one object changes state, all of its dependents are notified
and updated automatically.
=end


class Subject
  attr_reader :name

  def initialize
    @observers = []
  end

  def attach_observer(observer)
    observers << observer
  end

  def detach_observer(observer)
    observers.delete(observer)
  end

  def name=(name)
    @name = name
    notify_observers
  end

  private

  attr_reader :observers

  def notify_observers
    observers.each { |observer| observer.update(self) }
  end
end

class Observer
  attr_reader :subject

  def initialize(subject)
    @subject = subject
  end

  def update(changed_subject)
    @subject = changed_subject
  end
end

subject = Subject.new
observer = Observer.new(subject)
subject.attach_observer(observer)
subject.name = :name

p observer
