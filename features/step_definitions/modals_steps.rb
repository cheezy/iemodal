class MainPage
  include PageObject

  button(:launch_modal, :id => 'launch_modal_button')
end

class ModalDialog
  include PageObject

  button(:close_window, :id => 'close_window')
  button(:close_window_with_delay, :id => 'delayed_close')
  button(:launch_another_modal, :id => 'launch_modal_button')
end

class AnotherModalDialog
  include PageObject

  button(:close_window, :id => 'close_window')
  button(:close_window_with_delay, :id => 'delayed_close')
end

Given /^I am on the main page$/ do
  @browser.goto UrlHelper.main
end

When /^I open a modal$/ do
  @page = MainPage.new(@browser)
  @page.launch_modal
end

Then /^I should be able to close the modal$/ do
  @modal_dialog = ModalDialog.new(@browser)
  @modal_dialog.close_window
end
