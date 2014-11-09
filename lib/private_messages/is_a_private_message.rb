 
module PrivateMessages
  module IsAPrivateMessage
    extend ActiveSupport::Concern
 
    included do
    end
 
    module ClassMethods
      def is_private_message(options = {})
        options[:class_name] ||= 'User'
          
          unless included_modules.include? InstanceMethods 
            belongs_to :sender,
                       :class_name => options[:class_name],
                       :foreign_key => 'sender_id'
            belongs_to :recipient,
                       :class_name => options[:class_name],
                       :foreign_key => 'recipient_id'

            #extend ClassMethods 
            include InstanceMethods 
          end 

          #scope :already_read, :conditions => "read_at IS NOT NULL"
          #scope :unread, :conditions => "read_at IS NULL"
           scope :already_read, -> { where("read_at IS NOT NULL") }
           scope :unread, -> { where("read_at IS NULL") }
      end
      def read_message(id, reader)
          message = where("id=? and (sender_id = ? OR recipient_id = ?)", id, reader, reader).first()
          #message = self.find(id, :conditions => ["sender_id = ? OR recipient_id = ?", reader, reader]).first()
          if message.read_at.nil? && reader == message.recipient
            message.read_at = Time.now
            message.save!
          end
          message
      end

     
    end
    module InstanceMethods
        # Returns true or false value based on whether the a message has been read by it's recipient.
        def message_read?
          self.read_at.nil? ? false : true
        end

        # Marks a message as deleted by either the sender or the recipient, which ever the user that was passed is.
        # Once both have marked it deleted, it is destroyed.
        def mark_deleted(user)
          self.sender_deleted = true if self.sender == user
          self.recipient_deleted = true if self.recipient == user
          self.sender_deleted && self.recipient_deleted ? self.destroy : save!
        end
      end 
  end
end
 
ActiveRecord::Base.send :include, PrivateMessages::IsAPrivateMessage