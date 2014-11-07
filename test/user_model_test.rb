require 'test_helper'

class UserModelTest < ActiveSupport::TestCase

  def setup
    @jerry = create_user(:email => "jerry")
    @message = create_message
  end

  def test_unread_messages?
    assert @jerry.unread_messages?
  end

  def test_unread_message_count
    assert_equal @jerry.unread_message_count, 1
  end
end