require "rails_helper"

describe "The Welcome page" do
  include Capybara::DSL

  let(:user) { User.create(first_name: "krista") }
  it "has a title" do
    visit root_path
    expect(page).to have_content("UNLEASH")
  end

  it "has link to login" do
    visit root_path
    expect(page).to have_link("GET STARTED")
  end

  def mock_user
    allow_any_instance_of(ApplicationController)
    .to receive(:current_user).and_return(user)
  end
end
