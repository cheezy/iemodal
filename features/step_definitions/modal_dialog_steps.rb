class ModalPage
  include PageObject
  include IEModal

  page_url UrlHelper.modal
  button(:launch_modal, :id => 'launch_modal_button')
end

class ModalDialog
  include PageObject
  include IEModal

  button(:close_window, :id => 'close_window')
  button(:close_window_with_delay, :id => 'delayed_close')
  button(:launch_another_modal, :id => 'launch_modal_button')
end

class AnotherModalDialog
  include PageObject
  include IEModal

  button(:close_window, :id => 'close_window2')
  button(:close_window_with_delay, :id => 'delayed_close2')
end


Given /^I am on the modal page$/ do
  	visit_page ModalPage
end

When /^I open a modal dialog$/ do
	on_page ModalPage do |page|
    	page.modal_dialog do
      		page.launch_modal
    	end
  	end
end

Then /^I should be able to close the modal$/ do
	on_page ModalDialog do |page|
		page.close_window
  end
end

When /^I open another modal dialog from that one$/ do
  	on_page ModalDialog do |page|
  		page.modal_dialog do
			  page.launch_another_modal
		  end
  	end
end

Then /^I should be able to close both modals$/ do
  	on_page AnotherModalDialog do |page|
  		page.close_window 			
  	end
  
	on_page ModalDialog do |page|
		page.attach_to_window(:title => 'Modal 1')
		  page.close_window
  	end
  	
  	on_page ModalPage do |page|
  		page.attach_to_window(:url => 'modal.html')
  	end
end
