def js_disabled?
  page.has_selector?("html[class=no-js]")
end
