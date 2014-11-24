require 'spec_helper.rb'
describe Plaid, 'Call' do
  before(:all) do |_|
    # keys = YAML::load(IO.read('./keys.yml'))
    Plaid.config do |p|
      p.customer_id = "test_id" # keys['CUSTOMER_ID']
      p.secret = "test_secret" # keys['SECRET']
    end
  end

  it 'returns a response code of 200 for auth' do
    response = Plaid.call.add_account_auth('wells','plaid_test','plaid_good','test@plaid.com')
    expect(response[:code]).to eq(200)
  end

  it 'returns a response code of 200 for connect' do
    Plaid.call.add_account_connect('citi','plaid_test','plaid_good','test@plaid.com')
  end

  it 'calls get_place and returns a response code of 200' do
    place = Plaid.call.get_place('526842af335228673f0000b7')
    expect(place[:code]).to eq(200)
  end

  it 'returns a response code of 201' do
    Plaid.call.add_account_auth('chase','plaid_test','plaid_good','test@plaid.com')
  end

  it 'calls get_institutions and returns a response code of 200' do
    institutions = Plaid.call.get_institutions
    expect(institutions.any?).to eq(true)
  end

  it 'calls get_categories and returns a response code of 200' do
    categories = Plaid.call.get_categories
    expect(categories.any?).to eq(true)
  end
end

describe Plaid, 'Customer' do
  before :all do |_|
    # keys = YAML::load(IO.read('./keys.yml'))
    Plaid.config do |p|
      p.customer_id = "test_id" # keys['CUSTOMER_ID']
      p.secret = "test_secret" # keys['SECRET']
    end
  end

  it 'calls get_transactions and returns a response code of 200' do
    transactions = Plaid.customer.get_transactions('test')
    expect(transactions[:code]).to eq(200)
  end

  it 'calls mfa_step and returns a response code of 200 for auth' do
    new_account = Plaid.customer.mfa_auth_step('test','again','chase')
    expect(new_account[:code]).to eq(200)
  end

  it 'calls mfa_step and returns a response code of 200 for connect' do
    new_account = Plaid.customer.mfa_connect_step('test','again','chase')
    expect(new_account[:code]).to eq(200)
  end

  it 'calls delete_account and returns a response code of 200' do
    message = Plaid.customer.delete_account('test')
    expect(message[:code]).to eq(200)
  end
end
