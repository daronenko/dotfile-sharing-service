require 'rails_helper'

RSpec.describe Dotfile, type: :model do
  before(:each) do
    @user = User.create!(
     username: Faker::Internet.username(specifier: 6..10),
      email: Faker::Internet.email, 
      password: "password",
      encrypted_password: "password"
    )
  end

  subject do
    described_class.new(
      title: Faker::Lorem.sentence(word_count: 3),
      description: Faker::Lorem.paragraph(sentence_count: 3),
      config_type: "fish", 
      user_id: @user.id,
      file: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'config.fish'), 'text/plain') 
    )
  end
  
  it "is valid with valid attributes" do 
    expect(subject).to be_valid
  end

  it "is not valid when no title is entered" do
    subject.title = nil
    expect(subject).not_to be_valid
  end

  it "is not valid when no description is entered" do
    subject.description = nil
    expect(subject).not_to be_valid
  end

  it "is not valid when no config_type is provided" do
    subject.config_type = nil
    expect(subject).not_to be_valid
  end

  it "is not valid when no user_id is given" do
    subject.user_id = nil
    expect(subject).not_to be_valid
  end

  it "should belong to a user" do
    expect(subject.user).to eq(@user)
  end

  it "is not valid when title has invalid symbols" do
    subject.title = "title&"
    expect(subject).not_to be_valid
  end

  it "is not valid when description has invalid symbols" do
    subject.description = "description*"
    expect(subject).not_to be_valid
  end
end
