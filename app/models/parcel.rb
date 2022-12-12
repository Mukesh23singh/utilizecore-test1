require 'securerandom'
class Parcel < ApplicationRecord

	STATUS = ['Sent', 'In Transit', 'Delivered']
	PAYMENT_MODE = ['COD', 'Prepaid']

	validates :weight, :status, :cost, presence: true
	validates :status, inclusion: STATUS
	validates :payment_mode, inclusion: PAYMENT_MODE

	validates :cost, numericality: { greater_than_or_equal_to: 0, less_than: BigDecimal(10**5) }

	belongs_to :service_type
	belongs_to :sender, class_name: 'User'
	belongs_to :receiver, class_name: 'User'

	after_create :send_notification
	after_save :send_notification

	after_save do
      send_notification if self.changed.include?('status')
    end
    before_create :create_unique_id

	private

	def create_unique_id
      self.unique_id = SecureRandom.hex(10)
    end

	def send_notification
	  UserMailer.with(parcel: self).status_email.deliver_now
	  UserMailer.with(parcel: self).status_email_sender.deliver_now
	end

end
