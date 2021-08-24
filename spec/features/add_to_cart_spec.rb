require 'rails_helper'

RSpec.feature "Visitor add product to cart", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "see one more item in the cart" do
    # ACT
    visit root_path
    find("button[class='btn btn-primary']", visible: false, match: :first).click

    # DEBUG
    # save_screenshot

    # VERIFY
    within('a[href="/cart"]') { expect(page).to have_content('My Cart (1)') }
  end
end
