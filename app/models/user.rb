# == Schema Information
#
# Table name: users
#
#  id                   :bigint           not null, primary key
#  admin                :boolean          default("false")
#  avatar_content_type  :string
#  avatar_file_name     :string
#  avatar_file_size     :integer
#  avatar_updated_at    :datetime
#  city_state           :string
#  confirmation_sent_at :datetime
#  confirmed_at         :datetime
#  current_sign_in_at   :datetime
#  current_sign_in_ip   :inet
#  email                :string           default(""), not null
#  firstname            :string
#  last_sign_in_at      :datetime
#  last_sign_in_ip      :inet
#  lastname             :string
#  latitude             :float
#  longitude            :float
#  phone                :string
#  pin                  :string
#  remember_created_at  :datetime
#  sign_in_count        :integer          default("0"), not null
#  street_address       :string
#  token                :string
#  token_generated_at   :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules.
  # devise :database_authenticatable, :registerable,
  #         :recoverable, :rememberable, :trackable, :validatable,
  #         :confirmable, :omniauthable
  # devise :database_authenticatable, :authentication_keys => [:phone]
  # include DeviseTokenAuth::Concerns::User

  after_save do |ob|
    mqtt_me(ob)
  end

  has_many :requested, class_name: "Scenario", dependent: :nullify, inverse_of: :requester, foreign_key: :requester_id
  has_many :done, class_name: "Scenario", dependent: :nullify, inverse_of: :doer, foreign_key: :doer_id

  # has_many :verified, class_name: "Vouch", dependent: :nullify, inverse_of: :verifier, foreign_key: :verifier_id

  has_many :user_ad_interactions, dependent: :nullify

  has_attached_file :avatar, styles: {
    thumb: "100x100>",
    square: "200x200#",
    medium: "300x300>"
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :avatar, content_type: %r{\Aimage\/.*\Z}

  validates_presence_of :phone

  def name
    firstname + " " + lastname
  end

  # Methods to make Devise happy

  # def provider
  #   'phone'
  # end
  #
  # def uid
  #   phone + created_at.to_s
  # end
  #
  # def encrypted_password
  #   phone
  # end
  #
  # def encrypted_password_changed?
  #   false
  # end

  # def confirmation_token
  #   pin
  # end
  #
  # def confirmation_token=(token)
  #   self.pin = token
  # end
  #
  # def confirmation_sent_at=(timestamp)
  # end

  # end Devise methods

  def generate_pin!
    self.pin = rand(0000..9999).to_s.rjust(4, "0")
    save! 
  end

  def generate_token!
    self.token = SecureRandom.hex
    self.token_generated_at = Time.zone.now
    save!
  end

  def send_pin
    twilio_client.messages.create(
      to: phone,
      from: ENV['TWILIO_PHONE_NUMBER'],
      body: "Your PIN is #{pin}"
    )
  end

  def twilio_client
    Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
  end
end
