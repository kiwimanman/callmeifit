describe 'routing to profiles' do
  it 'routes /user' do
    expect(get: '/user').to route_to(
      controller: 'users',
      action: 'show'
    )
  end
end
