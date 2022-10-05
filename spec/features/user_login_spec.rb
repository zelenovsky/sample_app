RSpec.describe 'User Login/Logout' do
  specify 'login with invalid information' do
    visit login_path
    click_button 'Log in'
    expect(page).to have_text 'Invalid email/password combination'
    visit root_path
    expect(page).not_to have_text 'Invalid email/password combination'
  end

  let(:valid_user) { create(:user) }

  specify 'login with valid data then logout' do
    visit login_path

    fill_in 'Email', with: valid_user.email
    fill_in 'Password', with: valid_user.password
    click_button 'Log in'

    expect(page).to have_link('Profile', href: user_path(valid_user.id))
    expect(page).to have_link('Log out', href: logout_path)
    expect(page).not_to have_link('Log in', href: login_path)

    accept_alert do
      click_link 'Log out'      
    end

    expect(page).not_to have_link('Log out', href: logout_path)
    expect(page).to have_link('Log in', href: login_path)
  end
end
