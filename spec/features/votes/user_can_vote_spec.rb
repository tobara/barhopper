# require "rails_helper"

# feature 'user votes', %{
#   As an authenticated user
#   I want to upvote or downvote bars
#   So that bars can be ranked
#   Acceptance Criteria
#   [] I can upvote a bar
#   Acceptance Criteria
#   [] I can downvote a bar
#   Acceptance Criteria
#   [] I can change my upvote to a downvote
#   Acceptance Criteria
#   [] I can cancel an downvote to an upvote
#   Acceptance Criteria
#   [] I cannot upvote if I am not authenticated
#   [] I cannot downvote if I am not authenticated
# } do

#   let!(:user) { FactoryGirl.create(:user) }
#   let!(:bar) { FactoryGirl.create(:bar) }

#   scenario "user upvotes a bar" do
#     visit new_user_session_path

#     fill_in 'Username', with: user.username
#     fill_in 'Password', with: user.password
#     click_button "Sign In"

#     visit bars_path

#     click_link 'upvote'

#     expect(page).to have_content ("1")
#   end

#   scenario "user downvotes a bar" do
#     visit new_user_session_path

#     fill_in 'Username', with: user.username
#     fill_in 'Password', with: user.password
#     click_button "Sign In"

#     visit bars_path

#     click_link 'downvote'

#     expect(page).to have_content ("-1")
#   end

#   scenario "user changes upvote" do
#     visit new_user_session_path

#     fill_in 'Username', with: user.username
#     fill_in 'Password', with: user.password
#     click_button "Sign In"

#     visit bars_path

#     click_link 'upvote'
#     click_link 'downvote'

#     expect(page).to have_content ("-1")
#   end

#   scenario "user changes downvote" do
#     visit new_user_session_path

#     fill_in 'Username', with: user.username
#     fill_in 'Password', with: user.password
#     click_button "Sign In"

#     visit bars_path

#     click_link 'downvote'
#     click_link 'upvote'

#     expect(page).to have_content ("0")
#   end

#   scenario "unauthenticated user downvotes" do
#     visit bars_path

#     click_link 'downvote'

#     expect(page).to have_content ("You need to sign in")
#     expect(page).to_not have_content ("-1")
#   end

#   scenario "unauthenticated user upvotes" do
#     visit bars_path

#     click_link 'upvote'

#     expect(page).to have_content ("You need to sign in")
#     expect(page).to_not have_content ("1")
#   end
# end
