describe User do
  let(:role) { 'user' }
  let(:full_params) do
    {
      id: 49,
      name: 'Keith Stone',
      role: role
    }
  end
  let(:empty_params) { {} }
  let(:params) { full_params }
  let(:user) { described_class.new(params) }

  context '#logged_in?' do
    subject { user.logged_in? }

    context 'with a logged out user' do
      let(:params) { empty_params }
      it { should be_falsy }
    end

    context 'with a logged in user' do
      it { should be_truthy }
    end
  end

  context '#admin?' do
    subject { user.admin? }

    context 'with a logged out user' do
      let(:params) { empty_params }
      it { should be_falsy }
    end

    context 'with a logged in user' do
      it { should be_falsy }

      context 'with a nonsense role' do
        let(:role) { 'qwerty'}
        it { should be_falsy }
      end

      context 'with an admin role' do
        let(:role) { 'admin'}
        it { should be_truthy }
      end
    end
  end
end
