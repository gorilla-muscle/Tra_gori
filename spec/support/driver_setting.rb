RSpec.configure do |config|
  config.before(:each, type: :system) do
    
    # Spec実行時のブラウザ立ち上がりをOFF
    driven_by(:selenium_chrome_headless)
  end
end
