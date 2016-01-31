require "rails_helper"

feature 'user updates comment', %{
  As a user
  I want the option to update a comment
  Acceptance Criteria
  [X] I can update a comment
  [X] I can cancel an update comment
} do

  let!(:bar) { FactoryGirl.create(:bar) }
  let!(:user) { FactoryGirl.create(:user) }

  before(:each) do
    visit new_user_session_path

    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_button "Sign In"
    visit bar_path(bar)
  end

  scenario "a user updates a comment" do
    comment = FactoryGirl.create(:comment)
    click_link "Post Comment"
    fill_in 'Description', with: comment.description
    fill_in 'Rating', with: comment.rating
    click_on 'Add Comment'
    click_link "Edit"
    fill_in 'Description', with: "Different Comment"
    fill_in 'Rating', with: "9"
    click_button "Update Comment"
    expect(page).to have_content('Comment updated successfully')
    expect(page).to have_content("Different Comment")
  end

  scenario "a user cancels update comment" do
    comment = FactoryGirl.create(:comment)
    click_link "Post Comment"
    fill_in 'Description', with: comment.description
    fill_in 'Rating', with: comment.rating
    click_on 'Add Comment'
    click_link "Edit"
    click_link "Cancel"
    expect(page).to have_content(comment.description)
  end
end
