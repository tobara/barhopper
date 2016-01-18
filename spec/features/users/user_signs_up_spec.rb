require "rails_helper"

feature 'new user signs up', %{
  As a prospective user
  I want to sign up
  So I can post comments about bars

  Acceptance Criteria
  [] I will create an account from sign up page
  [] I must specify a valid username
  [] I must specify a valid e-mail
  [] I must specify a password and confirm that password
  [] I get error messages if I do not perform the above
  [] I register my account and am authenticated if I specify valid information
} do

  scenario "prospective user gets to sign up page from root path" do
    visit root_path
    click_on "Sign Up"
    expect(page).to have_content("Sign Up")
    expect(page).to have_content("Password confirmation")
  end

  scenario "prospective user correctly submits sign up form" do
    visit root_path
    click_link 'Sign Up'
    fill_in 'Username', with: 'Pablo'
    fill_in 'Email', with: 'escobar457@gmail.com'
    fill_in 'Password', with: 'money$17'
    fill_in 'Password confirmation', with: 'money$17'
    click_button 'Sign Up'
    expect(page).to have_content('Welcome! You can now enjoy')
    expect(page).to have_content('Sign Out')
  end

  scenario 'required information is not supplied' do
    visit root_path
    click_link 'Sign Up'
    click_button 'Sign Up'
    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content('Sign Out')
  end

  scenario 'password does not match confirmation' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'morepassword'
    click_button 'Sign Up'
    expect(page).to have_content("doesn't match")
    expect(page).to_not have_content('Sign Out')
  end
end
