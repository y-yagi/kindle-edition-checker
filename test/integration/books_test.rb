require 'test_helper'

class BooksTest < ActionDispatch::IntegrationTest
  setup do
    login
  end

  test 'register book' do
    assert_no_match 'いまさら翼といわれても', page.text

    VCR.use_cassette('check_isbn_and_set_title') do
      click_link '登録'
      fill_in 'book_isbn_10', with: '4041047617'
      click_button '登録'
    end

    assert_match 'いまさら翼といわれても', page.text
  end

  test 'destroy book' do
    books_count = users(:google).books.count
    assert_match 'スケッチブック', page.text

    page.accept_confirm do
      first(:link, '削除').click
    end

    assert_match /スケッチブック.*を削除しました/, page.text
    assert_equal books_count - 1, users(:google).books.count
  end
end
