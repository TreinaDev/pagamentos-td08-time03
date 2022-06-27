require 'rails_helper'

RSpec.describe 'routes for Widgets', :type => :routing do
  it 'routes /widgets/foo to the /foo action' do
    expect(get('/exchange_rates')).not_to  route_to('exchange_rates#index')
  end
end
