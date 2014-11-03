require 'test_helper'

class PrivateMessagesTest < ActiveSupport::TestCase
  
  def setup
    @jerry = create_user(:email => "jerry")
    @george = create_user(:email => "george")
    @message = create_message
  end

  def test_create_message
    @message = create_message
    
    assert_equal @message.sender, @george
    assert_equal @message.recipient, @jerry
    assert_equal @message.subject, "Frolf, Jerry!"
    assert_equal @message.body, "Frolf, Jerry! Frisbee golf!"
    assert @message.read_at.nil?
  end

  def test_read_returns_message
    assert_equal @message, Message.read_message(@message, @george)
  end
=begin

  def test_read_records_timestamp
    assert !@message.nil?
  end
  
  def test_read?
    Message.read_message(@message, @jerry)
    @message.reload
    assert @message.message_read?
  end
  
  def test_mark_deleted_sender
    @message.mark_deleted(@george)
    @message.reload
    assert @message.sender_deleted
  end

  def test_mark_deleted_recipient
    @message.mark_deleted(@jerry)
    @message.reload
    assert @message.recipient_deleted
  end

  def test_mark_deleted_both
    id = @message.id
    @message.mark_deleted(@jerry)
    @message.mark_deleted(@george)
    assert !Message.exists?(id)
  end
=end


end
