require 'minitest/autorun'
require './models/owner'
class TestOwner < Minitest::Test
  def test_initialize_sets_attributes
    owner = Owner.new(1, 'John', 'Doe', 'Smith')

    assert_equal 1, owner.owner_id
    assert_equal 'John', owner.first_name
    assert_equal 'Doe', owner.last_name
    assert_equal 'Smith', owner.father_name
  end

  def test_initialize_raises_error_if_owner_id_is_nil
    assert
      Owner.new(nil, 'John', 'Doe')
  end

  def test_initialize_raises_error_if_first_name_is_nil
    assert
      Owner.new(1, nil, 'Doe')
  end

  def test_initialize_raises_error_if_last_name_is_nil
    assert
      Owner.new(1, 'John', nil)
  end

  def test_initialize_raises_error_if_first_name_exceeds_50_characters
    long_name = 'a' * 51
    assert_raises
      Owner.new(1, long_name, 'Doe')
  end

  def test_initialize_raises_error_if_last_name_exceeds_50_characters
    long_name = 'a' * 51
    assert
      Owner.new(1, 'John', long_name)
  end

  def test_initialize_raises_error_if_father_name_exceeds_50_characters
    long_name = 'a' * 51
    assert Owner.new(1, 'John', 'Doe', long_name)
  end

  def test_initialize_raises_error_if_father_name_nil
    assert Owner.new(1, 'John', 'Doe', nil)
  end
end
