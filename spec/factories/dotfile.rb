FactoryBot.define do
  factory :dotfile do
    title { Faker::Lorem.sentence(word_count: 3) }
    description { Faker::Lorem.paragraph(sentence_count: 3) }
    config_type { "fish" }
    user { FactoryBot.create(:user) }
    file { Rack::Test::UploadedFile.new('spec/fixtures/config.fish', 'text/fish') }
  end
end
