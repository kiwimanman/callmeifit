describe UsersController do
  context '#show' do
    context 'without a logged in user' do
      before do
        get :show
      end
      it { expect(response.status).to be 302 }
    end

    context 'with a logged in user' do
      before do
        user = create(:user)
        @controller.stub(:session).and_return(user_id: user.id)
        get :show
      end
      it { expect(assigns(:logged_in_user)).to_not be_nil }
      it { expect(response.status).to be 200 }
    end
  end
end
