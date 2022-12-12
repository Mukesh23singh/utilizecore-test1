class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
	validates :name, presence: true

	has_one :address
	has_many :sender, foreign_key: :sender_id, class_name: 'Parcel'
	has_many :receiver, foreign_key: :receiver_id, class_name: 'Parcel'

	accepts_nested_attributes_for :address


	def name_with_address
	  if self.address
		address_string = [address.address_line_one, address.city, address.state, address.country, address.pincode].join('-')
	  end
	  @name_with_address ||= [name, address_string].join('-')
	end
end
