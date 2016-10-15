class User < ApplicationRecord
  has_many :books

  class << self
    def find_or_create_from_auth_hash(auth)
      find_by(provider: auth['provider'], uid: auth['uid']) || create_with_omniauth!(auth)
    end

    def create_with_omniauth!(auth)
      create! do |u|
        u.provider = auth['provider']
        u.uid = auth['uid']
        u.email = auth['info']['email'].presence || ''
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
end
