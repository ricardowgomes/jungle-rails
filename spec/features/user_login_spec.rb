require 'rails_helper'

RSpec.feature "Visitor login into the website", type: :feature, js: true do

  # SETUP
  before :each do
    @user = User.create!(
      name: 'Test User',
      email: 'test@example.com',
      password: 'test01',
      password_confirmation: 'test01'
    )
  end

  scenario "see one more item in the cart" do
    # ACT
    visit login_path
    fill_in 'email', with: 'test@example.com'
    fill_in 'password', with: 'test01'
    find("input[type='submit']", match: :first).click

    # DEBUG
    # save_screenshot

    # VERIFY
    expect(page).to have_content('Test User')
  end
end
