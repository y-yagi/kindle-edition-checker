require "test_helper"

class Books::ImportControllerTest < ActionController::TestCase
  setup do
    stub_request(:get, /webservices\.amazon\.co\.jp\.*/)
      .to_return(body: file_fixture("ecs-response.xml"))
  end

  setup do
    session[:user_id] = users(:google).id
  end

  test "import book" do
    assert_difference("Book.count") do
      post :create, params: { isbn_10: "4041047617"}
    end
    assert_response :success

    book = Book.last
    assert_equal book.user, users(:google)
    assert_equal "いまさら翼といわれても", book.title
  end
end
