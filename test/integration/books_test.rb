require 'test_helper'

class BooksTest < ActionDispatch::IntegrationTest
  setup do
    Capybara.current_driver = Capybara.javascript_driver
    login
  end

  teardown do
    Capybara.current_driver = Capybara.default_driver
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
    assert_match 'ひだまりスケッチ', page.text

    page.accept_confirm do
      all(:link, '削除').last.click
    end

    visit books_path
    assert_equal books_count - 1, users(:google).books.count
    assert_no_match 'ひだまりスケッチ', page.text
  end
end