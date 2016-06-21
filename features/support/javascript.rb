def js_disabled?
  page.has_selector?("html[class=no-js]")
end

def js_enabled?
  !js_disabled?
end

def js_test?
  Capybara.current_driver == Capybara.javascript_driver
end
