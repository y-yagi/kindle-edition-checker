class Book < ApplicationRecord
  belongs_to :user
  validates :isbn_10, presence: true, length: { is: 10 }
  validate :check_isbn_and_set_name

  class << self
    def build(params, current_user)
      book = Book.new(params)
      book.user = current_user
      book
    end
  end

  def amazon_url
    "https://www.amazon.co.jp/dp/#{isbn_10}/"
  end

  def check_isbn_and_set_name
    return unless self.errors[:isbn_10].blank?

    item = Amazon::Ecs.item_lookup(isbn_10, { ResponseGroup: 'ItemAttributes,AlternateVersions' })
    if item.error
      errors.add(:aws, item.error)
      return
    end
    self.title = item.get_element('ItemAttributes/Title').get

    alternate_versions = res.get_element('AlternateVersions')
    if alternate_versions
      self.has_kindle_edition = true
    end
  end
end
