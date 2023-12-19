require 'rails_helper'
require 'shared_contexts'

RSpec.describe "Dotfile Tests", type: :feature do
  include_context "api request authentication helper methods"

  let(:user) { FactoryBot.create(:user) } 
  let(:dotfile) { FactoryBot.create(:dotfile, user: user) }

  before do
    sign_in user
  end

  scenario "create new dotfile" do
    visit new_dotfile_path
   
    expect(page).to have_content("Creating")

    title = Faker::Lorem.sentence(word_count: 3)
    description = Faker::Lorem.paragraph(sentence_count: 3)

    find("#title").set(title)
    find("#description").set(description)
    find("#config_type").select("fish")
    find("#file").attach_file("spec/fixtures/config.fish")

    find("#create_button").click
    
    expect(page).to have_content("Dotfile was successfully created.")
    expect(page).to have_content(title)
    expect(page).to have_content(description)
    expect(page).to have_content("fish")
  end

  scenario "edit title" do
    visit edit_dotfile_path(id: dotfile.id)
    expect(page).to have_content("Editing")

    title = Faker::Lorem.sentence(word_count: 3)
    find("#title").set(title)

    click_on "Apply"

    expect(page).to have_content("Dotfile was successfully updated.")
    expect(page).to have_content(title)
  end

  scenario "edit description" do
    visit edit_dotfile_path(id: dotfile.id)
    expect(page).to have_content("Editing")

    description = Faker::Lorem.paragraph(sentence_count: 3)
    find("#description").set(description)

    click_on "Apply"

    expect(page).to have_content("Dotfile was successfully updated.")
    expect(page).to have_content(description)
  end

  scenario "edit config type" do
    visit edit_dotfile_path(id: dotfile.id)
    expect(page).to have_content("Editing")

    config_type = "tmux"
    find("#config_type").select(config_type)

    click_on "Apply"

    expect(page).to have_content("Dotfile was successfully updated.")
    expect(page).to have_content(config_type)
  end
end
