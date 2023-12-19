require 'rails_helper'
require 'shared_contexts'

RSpec.describe "User Tests", type: :feature do
  include_context "api request authentication helper methods"

  let(:user) { FactoryBot.create(:user) }

  scenario "valid sign up" do
    visit new_user_registration_path

    fill_in "Username", with: "#{Faker::Internet.username(specifier: 6..10)}"
    fill_in "Email", with: "#{Faker::Internet.email}"

    password = Faker::Internet.password
    fill_in "Password", with: "#{password}"
    fill_in "Confirm Password", with: "#{password}"

    click_on "Sign Up"

    expect(page).to have_content("Welcome! You have signed up successfully.")
  end 

  scenario "valid log in" do
    visit new_user_session_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_on "Log In"

    expect(page).to have_content("Signed in successfully.")
  end

  scenario "change user email" do
    sign_in user

    visit edit_user_registration_path

    fill_in "New Email", with: "#{Faker::Internet.email}"
    fill_in "Current Password", with: "#{user.password}"

    click_on "Apply"

    visit dotfiles_path

    expect(page).to have_content("Your account has been updated successfully.")
  end

  scenario "change user password" do
    sign_in user

    visit edit_user_registration_path

    new_password = Faker::Internet.password
    fill_in "New Password", with: "#{new_password}" 
    fill_in "Confirm New Password", with: "#{new_password}" 
    fill_in "Current Password", with: "#{user.password}"

    click_on "Apply"

    visit dotfiles_path

    expect(page).to have_content("Your account has been updated successfully.")
  end
end
