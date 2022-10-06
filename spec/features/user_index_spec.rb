RSpec.describe 'User index' do
  let(:users) { create_list(:faker_user, 30) }
  let(:login) do
    visit login_path
    fill_in 'Email', with: users.first.email
    fill_in 'Password', with: users.first.password
    click_button 'Log in'
  end

  specify 'pagination exists' do
    login
    visit users_path
    within '.pagy-nav' do
      expect(page).to have_link
    end
  end
end
