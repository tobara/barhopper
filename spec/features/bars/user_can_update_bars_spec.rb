require 'rails_helper'

feature "The bar edit page: ", %{
  As an authenticated user
  I want to edit an existing bar I created
  So that I can make my bars more correct
  Acceptance Criteria
  [X] I am authenticated and I can access an update page to edit my
      bar.
  [X] I see errors if update form invalid
} do

  let!(:bar) { FactoryGirl.create(:bar, user: user) }
  let!(:user) { FactoryGirl.create(:user) }

  before(:each) do
  visit new_user_session_path

  fill_in "Username", with: user.username
  fill_in "Password", with: user.password
  click_button 'Sign In'
  end

  scenario "creator can see the edit page" do
    visit bar_path(bar)
    click_link "Update"

    expect(page).to have_content "Update BAR Form"
  end

  scenario "creator validly edits the bar" do
    visit edit_bar_path(bar)

    expect(find_field("Name").value).to eq bar.name

    fill_in "Name", with: "Deep Elum"
    fill_in "Location", with: "Allston"
    fill_in "Address", with: "477 Cambridge St, Allston, MA 02134"
    click_button "Update Bar"

    expect(page).to have_content "BAR updated successfully"
    expect(page).to have_content "Deep Elum"
    expect(page).to have_content "Allston"
    expect(page).to have_content "477 Cambridge St, Allston, MA 02134"
  end

  scenario "creator invalidly edits bar" do
    visit edit_bar_path(bar)

    expect(find_field("Name").value).to eq bar.name

    fill_in "Name", with: ""
    fill_in "Location", with: ""
    fill_in "Address", with: ""
    click_button "Update Bar"

    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Location can't be blank"
    expect(page).to have_content "Address can't be blank"
  end
end
