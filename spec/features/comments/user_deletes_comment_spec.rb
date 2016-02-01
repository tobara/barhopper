require "rails_helper"

feature 'user deletes comment', %{
  As a user
  I want to delete a comment
  Acceptance Criteria
  [X] I can delete a comment
} do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user) }
  let!(:bar) { FactoryGirl.create(:bar, user: user) }

  before(:each) do
    visit new_user_session_path

    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_button "Sign In"

    visit bar_path(bar)

    click_link 'Post Comment'
    fill_in 'Description', with: 'Sweet.'
    fill_in 'Rating', with: '9'
    click_button 'Add Comment'
  end

  scenario "an authorized user can delete a comment" do
    click_button "Delete"
    expect(page).to have_content('Comment Destroyed!')
    expect(page).to_not have_content('Sweet.')
  end

  scenario "only authorized user can delete comment" do
    click_link 'Sign Out'
    visit new_user_session_path
    fill_in "Username", with: user2.username
    fill_in "Password", with: user2.password
    click_button "Sign In"

    visit bar_path(bar)
    expect(page).to_not have_content('Delete')
  end
end
