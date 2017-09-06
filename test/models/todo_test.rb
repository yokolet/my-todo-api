require 'test_helper'

class TodoTest < ActiveSupport::TestCase
  def setup
    @todo = todos(:one)
  end

  test "todo should have many-items" do
    #should have_many(:items).dependent(:destroy)
    assert_equal 2, @todo.items.size
  end

  test "todo should have title and created_by" do
    #should validate_presence_of(:title)
    assert @todo.valid?
  end

  test "todo should fail without two params" do
    wrong = Todo.new({ title: "wrong"})
    refute wrong.valid?
  end
end
