require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    described_class.new(
      username: Faker::Internet.username(specifier: 6..10),
      email: Faker::Internet.email,
      password: "password",
      encrypted_password: "password"
    )
  end

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid when email is not entered" do
    subject.email = nil
    expect(subject).not_to be_valid
  end

  it "is not valid when username is not entered" do
    subject.username = nil
    expect(subject).not_to be_valid
  end

  it "is valid when encrypted password is not entered" do
    subject.encrypted_password = nil
    expect(subject).to be_valid
  end

  it "is not valid when username has spaces" do
    subject.username = "user name"
    expect(subject).not_to be_valid
  end

  it "is not valid when username has invalid symbols" do
    subject.username = "username^"
    expect(subject).not_to be_valid
  end

  it "is not valid when email has invalid format" do
    subject.email = "email"
    expect(subject).not_to be_valid
  end

  it "is not valid when email has invalid symbols" do
    subject.email = "ma&l@gmail.com"
    expect(subject).not_to be_valid
  end
end
