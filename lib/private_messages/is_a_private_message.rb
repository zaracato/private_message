 
module PrivateMessages
  module IsAPrivateMessage
    extend ActiveSupport::Concern
 
    included do
    end
 
    module ClassMethods
      def is_private_message(options = {})
        options[:class_name] ||= 'User'
          
          #unless included_modules.include? InstanceMethods 
            belongs_to :sender,
                       :class_name => options[:class_name],
                       :foreign_key => 'sender_id'
            belongs_to :recipient,
                       :class_name => options[:class_name],
                       :foreign_key => 'recipient_id'

            #extend ClassMethods 
            #include InstanceMethods 
          #end 

          #scope :already_read, :conditions => "read_at IS NOT NULL"
          #scope :unread, :conditions => "read_at IS NULL"
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
  end
end
 
ActiveRecord::Base.send :include, PrivateMessages::IsAPrivateMessage