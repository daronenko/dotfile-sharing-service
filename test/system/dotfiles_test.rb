require "application_system_test_case"

class DotfilesTest < ApplicationSystemTestCase
  setup do
    @dotfile = dotfiles(:one)
  end

  test "visiting the index" do
    visit dotfiles_url
    assert_selector "h1", text: "Dotfiles"
  end

  test "should create dotfile" do
    visit dotfiles_url
    click_on "New dotfile"

    fill_in "Config type", with: @dotfile.config_type
    fill_in "Description", with: @dotfile.description
    fill_in "Title", with: @dotfile.title
    click_on "Create Dotfile"

    assert_text "Dotfile was successfully created"
    click_on "Back"
  end

  test "should update Dotfile" do
    visit dotfile_url(@dotfile)
    click_on "Edit this dotfile", match: :first

    fill_in "Config type", with: @dotfile.config_type
    fill_in "Description", with: @dotfile.description
    fill_in "Title", with: @dotfile.title
    click_on "Update Dotfile"

    assert_text "Dotfile was successfully updated"
    click_on "Back"
  end

  test "should destroy Dotfile" do
    visit dotfile_url(@dotfile)
    click_on "Destroy this dotfile", match: :first

    assert_text "Dotfile was successfully destroyed"
  end
end
