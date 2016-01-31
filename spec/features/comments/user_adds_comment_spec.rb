# require "rails_helper"

# feature 'user creates comment', %{
#   As a user
#   I want add a comment
#   So people know what I think about a bar
#   Acceptance Criteria
#   [X] I am not authenticated and I cannot add a comment
#   [X] I am authenticated and I can add a comment
#   [X] I cannot add a comment without filling all fields
# } do

#   let!(:bar) { FactoryGirl.create(:bar, user: user) }
#   let!(:user) { FactoryGirl.create(:user) }

#   before(:each) do
#     visit new_user_session_path

#     fill_in "Username", with: user.username
#     fill_in "Password", with: user.password
#     click_button 'Sign In'

#     visit bar_path(bar)

#     click_link 'Post Comment'
#   end

#   scenario "an unauthenticated user cannot add a comment" do
#     click_link 'Sign Out'
#     visit bar_path(bar)

#     expect(page).not_to have_link('Add Comment')

#     visit new_bar_comment_path(bar)
#     expect(page).to have_content('You need to sign in')
#   end

#   scenario "an authenticated user adds a comment" do
#     comment = FactoryGirl.create(:comment)
#     fill_in 'Description', with: comment.description
#     fill_in 'Rating', with: comment.rating
#     click_on 'Add Comment'

#     expect(page).to have_content('Comment added successfully')
#   end

#   scenario "a user must fill out all fields" do
#     click_on 'Add Comment'

#     expect(page).to have_content("Description can't be blank")
#     expect(page).to have_content("Rating can't be blank")
#   end

#   scenario "a user cancels add comment" do
#     click_on 'Add Comment'
#     click_link "Cancel"

#     expect(current_path).to eq bar_path(bar)
#   end
# end
