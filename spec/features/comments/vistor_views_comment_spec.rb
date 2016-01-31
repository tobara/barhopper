# require "rails_helper"

# feature 'user views comment', %{
#   A user or vistor
#   I want to view comments
#   Acceptance Criteria
#   [X] I can view comments
# } do

#   let!(:user) { FactoryGirl.create(:user) }
#   let!(:bar) { FactoryGirl.create(:bar, user: user) }

#   before(:each) do
#     visit new_user_session_path

#     fill_in "Username", with: user.username
#     fill_in "Password", with: user.password
#     click_button "Sign In"
#     visit bar_path(bar)
#   end

#   scenario "a user can view comments" do
#     comment = FactoryGirl.create(:comment)
#     user1 = FactoryGirl.create(:user)
#     visit bar_path(bar)
#     click_link "Post Comment"
#     fill_in 'Description', with: comment.description
#     fill_in 'Rating', with: comment.rating
#     click_on 'Add Comment'
#     click_on 'Sign Out'

#     visit new_user_session_path

#     fill_in "Username", with: user1.username
#     fill_in "Password", with: user1.password
#     click_button "Sign In"
#     visit bar_path(bar)

#     expect(page).to have_content comment.description
#     expect(page).to have_content comment.rating
#   end
# end
