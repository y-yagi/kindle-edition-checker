class User < ApplicationRecord
  has_many :books

  validates :pushbullet_api_token, presence: true, if: -> { pushbullet_notification }

  before_save :encrypt_pushbullet_api_token

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

  def encrypt_pushbullet_api_token
    if pushbullet_api_token_changed? && pushbullet_api_token.present?
      self.pushbullet_api_token = Rails.application.message_verifier(:pushbullet_api_token).generate(pushbullet_api_token)
    end
  end

  def raw_pushbullet_api_token
    Rails.application.message_verifier(:pushbullet_api_token).verify(pushbullet_api_token)
  end

  def maskd_pushbullet_api_token
    pushbullet_api_token.present? ? '************' : ''
  end
end
