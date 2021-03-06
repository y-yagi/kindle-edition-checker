require 'test_helper'

class BookTest < ActiveSupport::TestCase
  setup do
    stub_request(:get, /webservices\.amazon\.co\.jp\.*/)
      .to_return(body: file_fixture("ecs-response.xml"))
  end

  sub_test_case('validation') do
    test 'should have the necessary required validators' do
      book = Book.new(user: users(:google))
      assert_not book.valid?
      assert_equal [:isbn_10], book.errors.keys
    end

    test 'validate error when set 11 character in isbn' do
      book = Book.new(isbn_10: 'a' * 11, user: users(:google))
      assert_not book.valid?
      assert_includes book.errors.keys, :isbn_10
    end
  end

  test 'build return Book instance' do
    params = ActionController::Parameters.new(isbn_10: '1234567890')
    params.permit!
    book = Book.build(params, users(:google))
    assert_instance_of Book, book
    assert_equal book.user_id, users(:google).id
    assert_equal book.isbn_10, '1234567890'
  end

  test 'set title and release date when saved' do
    book = Book.new(isbn_10: '4041047617', user: users(:google))
    book.save!
    assert_equal 'いまさら翼といわれても', book.title
    assert_equal Date.parse("2016-11-26"), book.release_date
  end

  test 'set_kindle_edition_info set kindle info' do
    book = books(:has_kindle_edition_but_not_set)
    assert_not book.has_kindle_edition
    assert_not book.kindle_edition_release_date

    book.set_kindle_edition_info!

    book.reload
    assert book.has_kindle_edition
    assert_equal Date.parse('2016-11-26'), book.kindle_edition_release_date
  end
end
