require 'rails_helper'

feature "The bar add page: ", %{
  As a user
  I want to add a bar
  So that I can let everyone its a good place to go
  Acceptance Criteria
  [X] I am authenticated and can access the new bar form.
  [X] I cannot access new bar form if I am not authenticated
  [X] I can create a new barwith valid info
  [X] I cannot create a new bar with invalid form info
  [X] I can only add a bar if it has not already been added
} do

  let!(:user) { FactoryGirl.create(:user) }

  before(:each) do
    visit new_user_session_path

    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_button 'Sign In'
  end

  scenario "authenticated user access new bar form" do
    visit new_bar_path

    click_button 'Add Bar'
    expect(page).to have_content('New BAR Form')
  end

  scenario "authenticated user adds new bar successfully" do
    visit new_bar_path

    fill_in "Name", with: "Corner Tavern"
    fill_in "Location", with: "Back Bay"
    fill_in "Address", with: "421 Marlborough St, Boston, MA 02115"
    click_button "Add Bar"

    expect(page).to have_content "BAR added successfully"
    expect(page).to have_content "Back Bay"
    expect(page).to have_content "Corner Tavern"
  end

  scenario "authenticated user inputs incorrect info" do
    visit new_bar_path
    click_button "Add Bar"

    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Location can't be blank"
    expect(page).to have_content "Address can't be blank"
  end

  scenario "authenticated user adds repeat bar" do
    visit new_bar_path

    fill_in "Name", with: "Corner Tavern"
    fill_in "Location", with: "Back Bay"
    fill_in "Address", with: "421 Marlborough St, Boston, MA 02115"
    click_button "Add Bar"

    visit new_bar_path

    fill_in "Name", with: "Corner Tavern"
    fill_in "Location", with: "Back Bay"
    fill_in "Address", with: "421 Marlborough St, Boston, MA 02115"
    click_button "Add Bar"

    expect(page).to_not have_content "BAR added successfully"
  end

  scenario "unauthenticated user cannot see add new bar link" do
    click_link 'Sign Out'
    visit bars_path
    expect(page).to_not have_content('Add Bar')
  end

  scenario "authenticated user cancels new bar submission" do
    visit new_bar_path
    click_link 'Cancel'
    expect(current_path).to eq bars_path
  end
end
