describe UsersController do
  context "#show" do
    context "without a logged in user" do
      before do
        get :show
      end
      it { expect(response.status).to be 302 }
    end

    context "with a logged in user" do
      before do
        user = create(:user)
        allow(@controller).to receive(:session) do
          { user_id: user.id }
        end
        get :show
      end

      it { expect(response.status).to be 200 }
    end
  end
end
