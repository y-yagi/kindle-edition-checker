class User < ApplicationRecord
  has_many :books

  class << self
    def find_or_create_from_auth_hash(auth)
      find_by(provider: auth['provider'], uid: auth['uid']) || create_with_omniauth!(auth)
    end

    def create_with_omniauth!(auth)
      create! do |u|
        u.provider = auth['provider']
        u.email = auth['info']['email'].presence || ''
        u.uid = auth['uid']
      end
    end
  end

  def update_if_needed!(auth)
    new_email = auth['info']['email']
    if new_email.present? && email != new_email
      self.email = new_email
    end
    save! if changed?
  end

  def encrypt_device_token
    if device_token_changed? && device_token.present?
      self.device_token = Rails.application.message_verifier(:device_token).generate(device_token)
    end
  end

  def raw_device_token
    Rails.application.message_verifier(:device_token).verify(device_token)
  end
end
