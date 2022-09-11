RSpec.describe 'User Login' do
  specify 'login with invalid information' do
    visit login_path
    click_button 'Log in'
    expect(page).to have_text 'Invalid email/password combination'
    visit root_path
    expect(page).not_to have_text 'Invalid email/password combination'
  end

  let(:valid_user) { create(:user) }
  specify 'login with valid information' do
    visit login_path

    fill_in 'Email', with: valid_user.email
    fill_in 'Password', with: valid_user.password
    click_button 'Log in'

    expect(page).to have_link('Profile', href: user_path(valid_user.id))
    expect(page).not_to have_link('Log in', href: login_path)
  end
end
