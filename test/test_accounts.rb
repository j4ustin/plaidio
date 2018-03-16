require_relative 'test_helper'

# Internal: The test for Plaid::Accounts.
class PlaidAccountsTest < PlaidTest
  def setup
    create_item initial_products: [:transactions]
  end

  # rubocop:disable Metrics/AbcSize

  def test_get
    response = client.accounts.get(access_token)
    refute_empty(response)

    account_id = response.accounts[0].account_id

    response = client.accounts.get(access_token, account_ids: [account_id])
    assert_equal(1, response.accounts.size)

    response = client.accounts.get(access_token,
                                   options: { account_ids: [account_id] })
    assert_equal(1, response.accounts.size)
  end

  def test_get_invalid_access_token
    assert_raises(Plaid::InvalidInputError) do
      client.accounts.get(BAD_STRING)
    end
  end

  def test_get_invalid_options
    assert_raises(Plaid::InvalidRequestError) do
      client.accounts.get(access_token, account_ids: BAD_STRING)
    end
  end

  def test_balance_get
    response = client.accounts.balance.get(access_token)
    refute_empty(response.accounts)

    account_id = response.accounts[0].account_id
    response = client.accounts.balance.get access_token,
                                           account_ids: [account_id]
    assert_equal 1, response.accounts.size

    response = client.accounts.balance.get(
      access_token,
      options: { account_ids: [account_id] }
    )
    assert_equal 1, response.accounts.size
  end

  # rubocop:enable Metrics/AbcSize

  def test_balance_get_invalid_access_token
    assert_raises(Plaid::InvalidInputError) do
      client.accounts.balance.get(BAD_STRING)
    end
  end

  def test_balance_get_invalid_options
    assert_raises(Plaid::InvalidRequestError) do
      client.accounts.balance.get(access_token, account_ids: BAD_STRING)
    end
  end
end
