require_relative 'test_helper'

# Internal: The test for Plaid::Liabilities.
class PlaidLiabilitiesTest < PlaidTest
  # rubocop:disable Metrics/AbcSize

  def test_get
    create_item initial_products: [:liabilities]

    response = client.liabilities.get(access_token)
    refute_empty(response.accounts)
    refute_empty(response.liabilities)
    refute_empty(response.liabilities.student)

    account_id = response.accounts[7].account_id
    response = client.liabilities.get(
      access_token,
      account_ids: [account_id]
    )
    assert_equal(1, response.liabilities.student.size)
  end

  # rubocop:enable Metrics/AbcSize

  def test_get_invalid_access_token
    assert_raises(Plaid::InvalidInputError) do
      client.liabilities.get(BAD_STRING)
    end
  end
end
