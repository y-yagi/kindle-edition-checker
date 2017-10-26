require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium_chrome_headless

  def login
    visit '/auth/google_oauth2'
  end
end

module ActionDispatch::SystemTesting::TestHelpers::ScreenshotHelper
  def take_screenshot
    save_image
    open_image
  end

  def open_image
    system("xdg-open #{image_path}")
  end
end
