class Book < ApplicationRecord
  belongs_to :user
  validates :isbn_10, presence: true, length: { is: 10 }
  validate :check_isbn_and_set_title

  scope :unnotified, -> { where(has_kindle_edition: true, notified: false) }

  class << self
    def build(params, current_user)
      book = Book.new(params)
      book.user = current_user
      book
    end

    def set_kindle_edition_info!
      Book.where(has_kindle_edition: nil).find_each do |book|
        begin
          book.set_kindle_edition_info!
        rescue => e
          Rails.logger.error(e)
        end
      end
    end
  end

  def amazon_url
    "https://www.amazon.co.jp/dp/#{isbn_10}/"
  end

  def check_isbn_and_set_title
    return unless self.errors[:isbn_10].blank?
    return unless isbn_10_changed?

    item = Amazon::Ecs.item_lookup(isbn_10, { ResponseGroup: 'ItemAttributes,AlternateVersions' })
    if item.error
      errors.add(:aws, item.error)
      return
    end
    self.title = item.get_element('ItemAttributes/Title').get
  end

  def set_kindle_edition_info!
    item = Amazon::Ecs.item_lookup(isbn_10, { ResponseGroup: 'ItemAttributes,AlternateVersions' })
    if item.error
      errors.add(:aws, item.error)
      return
    end

    alternate_versions = item.get_element('AlternateVersions')
    return unless alternate_versions

    self.has_kindle_edition = true

    # NOTE For avoid 503 error.
    sleep 3

    asin = alternate_versions.get_element("AlternateVersion/ASIN").get
    item = Amazon::Ecs.item_lookup(asin, { ResponseGroup: 'ItemAttributes,AlternateVersions' })
    unless item.error
      self.kindle_edition_release_date = item.get_element("ReleaseDate").get
    end
    save!
  end
end
