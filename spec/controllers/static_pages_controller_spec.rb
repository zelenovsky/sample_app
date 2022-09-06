RSpec.describe StaticPagesController do
  describe "get home" do
    it "should response with 200" do
      get :home
      expect(response.status).to eq(200)
    end
  end
end
