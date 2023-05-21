require 'minitest/autorun'
require './models/car'
class TestCar < Minitest::Test
  def test_initialize_raises_error_with_null_car_id
    assert Car.new(nil, 'model', 1, 1)
  end

  def test_initialize_raises_error_with_null_model
    assert Car.new(1, nil, 1, 1)
  end

  def test_initialize_raises_error_with_null_owner_id
    assert Car.new(1, 'model', nil, 1)
  end

  def test_initialize_raises_error_with_null_tenant_id
    assert Car.new(1, 'model', 1, nil)
  end

  def test_initialize_raises_error_with_long_model
    long_model = 'a' * 256
    assert Car.new(1, long_model, 1, 1)
  end

  def test_car_attributes_are_set
    car = Car.new(1, 'model', 2, 3)

    assert_equal 1, car.car_id
    assert_equal 'model', car.model
    assert_equal 2, car.owner_id
    assert_equal 3, car.tenant_id
  end
end
