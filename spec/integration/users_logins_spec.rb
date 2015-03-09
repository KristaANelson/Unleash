require "rails_helper"

describe "The Welcome page" do
  include Capybara::DSL

  it "has a title" do
    visit root_path
    expect(page).to have_content("Unleash")
  end

  it "has link to login" do
    visit root_path
    expect(page).to have_link("GET STARTED")
  end
end
