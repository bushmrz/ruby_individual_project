require 'minitest/autorun'
require './lib/state_holders/list_state_notifier'
class TestListStateNotifier < Minitest::Test
  def setup
    @notifier = ListStateNotifier.new
  end

  def test_items_initialized_as_empty_array
    assert_equal [], @notifier.items
  end

  def test_set_all_sets_items_and_notifies_listeners
    listener = MiniTest::Mock.new
    listener.expect(:update, nil, [[1, 2, 3]])
    @notifier.add_listener(listener)

    @notifier.set_all([1, 2, 3])

    assert_equal [1, 2, 3], @notifier.items
    listener.verify
  end

  def test_add_adds_item_and_notifies_listeners
    listener = MiniTest::Mock.new
    listener.expect(:update, nil, [@notifier.items])
    @notifier.add_listener(listener)

    @notifier.add(4)

    assert_equal [4], @notifier.items
    listener.verify
  end

  def test_get_returns_correct_item
    @notifier.set_all([1, 2, 3])

    assert_equal 2, @notifier.get(1)
  end

  def test_delete_removes_item_and_notifies_listeners
    @notifier.set_all([1, 2, 3])
    listener = MiniTest::Mock.new
    listener.expect(:update, nil, [@notifier.items])
    @notifier.add_listener(listener)

    @notifier.delete(2)

    assert_equal [1, 3], @notifier.items
    listener.verify
  end

  def test_replace_replaces_item_and_notifies_listeners
    @notifier.set_all([1, 2, 3])
    listener = MiniTest::Mock.new
    listener.expect(:update, nil, [@notifier.items])
    @notifier.add_listener(listener)

    @notifier.replace(2, 4)

    assert_equal [1, 4, 3], @notifier.items
    listener.verify
  end

  def test_add_listener_adds_listener
    listener = MiniTest::Mock.new

    @notifier.add_listener(listener)

    assert_includes @notifier.instance_variable_get(:@listeners), listener
  end

  def test_delete_listener_removes_listener
    listener = MiniTest::Mock.new
    @notifier.add_listener(listener)

    @notifier.delete_listener(listener)

    refute_includes @notifier.instance_variable_get(:@listeners), listener
  end
end