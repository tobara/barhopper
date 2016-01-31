# require "rails_helper"

# feature 'user signs in', %{
#   As a user
#   I want to sign in
#   So that I can post comments about bars
#   Acceptance Criteria
#   [X] I am authenticated and gain access to the system if I specify valid,
#       previously registered username and password.
#   [X] I remain unathenticated if I specify invalid username/password
#   [X] I cannot sign in again if I am already signed in
# } do

#   scenario 'existing user specifies a valid username and password' do
#     user = FactoryGirl.create(:user)
#     visit root_path
#     click_link 'Sign In'
#     fill_in 'Username', with: user.username
#     fill_in 'Password', with: user.password
#     click_button 'Sign In'
#     expect(page).to have_content('Signed in successfully')
#   end

#   scenario 'a nonexistent username and password is supplied' do
#     visit root_path
#     click_link 'Sign In'
#     fill_in 'Username', with: 'anonexistentuser'
#     fill_in 'Password', with: 'whawhawha'
#     click_button 'Sign In'
#     expect(page).to_not have_content('Signed in successfully')
#     expect(page).to have_content('Invalid username or password')
#   end

#   scenario 'an existing username with wrong password is denied access' do
#     user = FactoryGirl.create(:user)
#     visit root_path
#     click_link 'Sign In'
#     fill_in 'Username', with: user.username
#     fill_in 'Password', with: 'incorrectPassword'
#     click_button 'Sign In'
#     expect(page).to have_content('Invalid username or password')
#   end

#   scenario 'an alread authenticated user cannot re-sign in' do
#     user = FactoryGirl.create(:user)
#     visit new_user_session_path
#     fill_in 'Username', with: user.username
#     fill_in 'Password', with: user.password
#     click_button 'Sign In'
#     expect(page).to_not have_content('Already Signed In')
#   end
# end
