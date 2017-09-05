require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  def setup
    @item = items(:one)
  end
  # test "the truth" do
  #   assert true
  # end
  test "item should belong to a single todo" do
    #should belong_to(:todo)
    assert_not_nil @item.todo_id
  end

  test "item should have a name" do
    #should validate_presence_of(:name)
    assert @item.valid?
  end
end
