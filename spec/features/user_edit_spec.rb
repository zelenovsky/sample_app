RSpec.describe 'User edit' do
  let(:user) { create(:user) }
  let(:login) do
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  specify 'with invalid data' do
    visit edit_user_path(user.id)
    login
    fill_in 'Name', with: ''
    fill_in 'Email', with: 'foo@invalid'
    click_button 'Save changes'
    sleep(1)
    expect(page).to have_text 'Name can\'t be blank'
  end
end
