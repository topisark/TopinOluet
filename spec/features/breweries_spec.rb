require 'spec_helper'

describe "Breweries (integration tests)" do
  let!(:user) { FactoryGirl.create :user }
  breweryName = "Bestbrewery"
  breweryYear = 1990

  describe "when user is signed in" do
    before :each do
      sign_in(username: user.username, password: user.password)
      visit new_brewery_path
    end

    it "can't create a brewery without name" do
      click_button('Create Brewery')
      page.should have_content "can't be blank"
      Brewery.count.should be 0
    end

    it "can't create a brewery without year" do
      fill_in('brewery_year', with: breweryYear)
      click_button('Create Brewery')
      Brewery.count.should be 0
    end

    it "can create a brewery with year and name" do
      fill_in('brewery_year', with: breweryYear)
      fill_in('brewery_name', with: breweryName)
      click_button('Create Brewery')
      Brewery.count.should be 1
      page.should have_content "Brewery was successfully created"
    end

  end

  describe "when user is not signed in" do

    it "can't create a new brewery" do
      visit breweries_path
      page.should_not have_content "New Brewery"
    end

    it "can't visit new brewery page" do
      visit new_brewery_path
      page.should have_content "You need to be signed in!"
    end

  end

  describe "when a brewery has been created" do
    let!(:brewery) { FactoryGirl.create :brewery }

    before :each do
      sign_in(username: user.username, password: user.password)
      visit brewery_path(brewery)
    end

    it "its page can be visited" do
      page.should have_content brewery.name
    end

    it "it can be modified" do
      click_link "Edit"
      fill_in('brewery_name', with: brewery.name.reverse)
      click_button "Update Brewery"
      page.should have_content "Brewery was successfully updated"
    end

  end

end

describe "Breweries page" do
  let!(:user) { FactoryGirl.create :user }

  set_configurations_for_js_tests

  it "should not have any breweries before they have been created" do
    visit breweries_path
    expect(page).to have_content 'Number of breweries: 0'
  end

  describe "when breweries exists" do
    before :each do
      @breweries = create_multiple_breweries
      visit breweries_path
    end

    it "lists their total number" do
      expect(page).to have_content "Number of breweries: #{@breweries.count}"
    end

    it "shows the existing breweries", js: true do
      @breweries.each do |brewery|
        page.should have_content brewery
      end
    end

    it "can be dynamically searched", js: true do
      fill_in('brewerySearch', with: @breweries.first)
      page.should have_content @breweries.first
      @breweries.from(1).each do |brewery|
        page.should have_no_content brewery
      end
    end

  end

end
