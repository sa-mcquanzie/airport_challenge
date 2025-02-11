require 'weather'

class Airport
  attr_accessor :capacity, :planes, :weather

  def initialize(capacity = 1, weather = Weather.random, planes = [])
    @capacity = capacity >= 0 ? capacity : 1
    @weather = weather
    @planes = planes
  end

  def receive plane
    clear_for_landing plane
    plane.land
    @planes << plane
  end

  def release plane
    clear_for_takeoff plane
    plane.takeoff
    @planes.delete plane
  end

  private

  def clear_for_landing plane
    raise 'Only planes are allowed to land' unless plane.class == Plane
    raise 'Plane is not in flight' unless plane.in_flight?
    raise 'Unsafe landing conditions' unless safe?
    raise 'Airport at capacity' if full?
  end

  def clear_for_takeoff plane
    raise 'Plane is already in flight' if plane.in_flight?
    raise 'Plane not at airport' unless @planes.include? plane
    raise 'Unsafe takeoff conditions' unless safe?
  end

  def full?
    planes.size == @capacity
  end

  def safe?
    @weather == :clear
  end
end
