require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
  setup do
    stub_request(:get, /webservices\.amazon\.co\.jp\.*/)
      .to_return(body: file_fixture("ecs-response.xml"))

    Capybara.current_driver = Capybara.javascript_driver
    login
  end

  teardown do
    Capybara.current_driver = Capybara.default_driver
  end

  test 'mangement book' do
    assert_no_match 'いまさら翼といわれても', page.text

    click_link '登録'
    fill_in 'book_isbn_10', with: '4041047617'
    click_button '登録'

    assert_match 'いまさら翼といわれても', page.text
  end
end
