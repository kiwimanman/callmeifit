describe EmailsController, '#create' do
  let(:is_valid) { true }

  before do
    allow(EmailReceiver).to receive(:receive).and_return(is_valid)
    post :create
  end

  context 'when the request is valid' do
    it 'responds with success' do
      expect(response).to be_success
    end

    it 'responds with status ok' do
      expect(JSON.parse(response.body)['status']).to eq 'ok'
    end
  end

  context 'when the request is invalid' do
    let(:is_valid) { nil }

    it 'responds with 403 when request is invalid' do
      expect(response.status).to eq 403
    end

    it 'responds with status rejected' do
      status = JSON.parse(response.body)['status']
      expect(status).to eq 'rejected'
    end
  end
end
