RSpec.describe UsersController do
  let(:invalid_user_params) do
    {
      user: {
        name: '',
        email: 'user@invalid',
        password: 'foo',
        password_confirmation: 'bar'
      }
    }
  end

  let(:valid_user_params) do
    {
      user: {
        name: 'Artem',
        email: 'test@example.com',
        password: 'qweasdzxc',
        password_confirmation: 'qweasdzxc'
      }
    }
  end

  let(:create_invalid_user) { post :create, params: invalid_user_params, format: :turbo_stream }
  let(:create_valid_user) { post :create, params: valid_user_params, format: :html }

  specify 'invalid signup' do
    expect { create_invalid_user }.not_to change { User.count }
    expect(response.status).to eq(422)
  end

  specify 'valid signup' do
    expect { create_valid_user }.to change { User.count }.by(1)
    expect(create_valid_user).to redirect_to(user_path(assigns(:user).id))
    expect(response.status).to eq(302)
    expect(session[:user_id]).not_to be_nil
  end
end
