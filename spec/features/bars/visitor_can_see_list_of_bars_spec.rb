# require 'rails_helper'

# feature "The bar index page: ", %{
#   As a visitor
#   I want to view a list of bars
#   before I sign up
#   Acceptance Criteria
#   [X] I am un-authenticated and can still view all bars.

# } do

#   let!(:bar) { FactoryGirl.create(:bar) }

#   scenario "visitor can see list of bars on index page" do
#     visit bars_path

#     expect(page).to have_content bar.name
#     expect(page).to have_content bar.location
#   end

#   scenario "visitor clicks link for bar show page" do
#     visit bars_path

#     click_link bar.name
#     expect(current_path).to eq bar_path(bar)
#     expect(page).to have_content bar.location
#   end
# end
