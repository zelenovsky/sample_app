RSpec.describe 'Static Pages' do
  before do
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

  describe "home page" do
    it "should find title" do
      visit home_path
      expect(page).to have_title "Home | #{@base_title}"
    end
  end

  describe "about page" do
    it "should find title" do
      visit about_path
      expect(page).to have_title "About | #{@base_title}"
    end
  end

  describe "help page" do
    it "should find title" do
      visit help_path
      expect(page).to have_title "Help | #{@base_title}"
    end
  end

  describe "contact page" do
    it "should find title" do
      visit contact_path
      expect(page).to have_title "Contact | #{@base_title}"
    end
  end
end
