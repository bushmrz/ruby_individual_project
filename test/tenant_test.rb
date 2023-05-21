require 'minitest/autorun'
require './models/tenant'
class TestTenant < Minitest::Test
  def test_initialize_sets_attributes
    tenant = Tenant.new(1, 'John', 'Doe', '+79009009090')

    assert_equal 1, tenant.tenant_id
    assert_equal 'John', tenant.first_name
    assert_equal 'Doe', tenant.last_name
    assert_equal '+79009009090', tenant.phone
  end

  def test_initialize_raises_error_if_tenant_id_is_nil
    assert
    Tenant.new(nil, 'John', 'Doe')
  end

  def test_initialize_raises_error_if_first_name_is_nil
    assert
    Tenant.new(1, nil, 'Doe')
  end

  def test_initialize_raises_error_if_last_name_is_nil
    assert
    Tenant.new(1, 'John', nil)
  end

  def test_initialize_raises_error_if_first_name_exceeds_50_characters
    long_name = 'a' * 51
    assert_raises
    Tenant.new(1, long_name, 'Doe')
  end

  def test_initialize_raises_error_if_last_name_exceeds_50_characters
    long_name = 'a' * 51
    assert
    Tenant.new(1, 'John', long_name)
  end

  def test_initialize_raises_error_if_phone_uncorrect
    phone_er = +78
    assert Tenant.new(1, 'John', 'Doe', phone_er)
  end

  def test_initialize_raises_error_if_phone_nil
    assert Tenant.new(1, 'John', 'Doe', nil)
  end
end
