require 'test_helper'

class BooksTest < ActionDispatch::IntegrationTest
  setup do
    Capybara.current_driver = Capybara.javascript_driver
    login
  end

  teardown do
    Capybara.current_driver = Capybara.default_driver
  end

  test 'mangement book' do
    within('table.mdl-data-table') do
      assert_no_match 'いまさら翼といわれても', page.text
    end

    VCR.use_cassette('check_isbn_and_set_title') do
      click_link '登録'
      fill_in 'book_isbn_10', with: '4041047617'
      click_button '登録'
    end

    within('table.mdl-data-table') do
      assert_match 'いまさら翼といわれても', page.text
    end

    all(:link, '削除').last.click

    visit books_path
    within('table.mdl-data-table') do
      assert_no_match 'いまさら翼といわれても', page.text
    end
  end
end
