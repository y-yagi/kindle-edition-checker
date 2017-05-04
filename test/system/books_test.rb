require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
  setup do
    Capybara.current_driver = Capybara.javascript_driver
    login
  end

  teardown do
    Capybara.current_driver = Capybara.default_driver
  end

  test 'mangement book' do
    assert_no_match 'いまさら翼といわれても', page.text

    VCR.use_cassette('check_isbn_and_set_title') do
      click_link '登録'
      fill_in 'book_isbn_10', with: '4041047617'
      click_button '登録'
    end

    assert_match 'いまさら翼といわれても', page.text
  end
end
