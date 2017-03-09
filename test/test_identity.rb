require_relative 'plaid_test'

# Internal: The test for Plaid::Identity.
class PlaidIdentityTest < PlaidTest
  def setup
    @client = create_client
    @item = @client.item.create(credentials: CREDENTIALS,
                                institution_id: SANDBOX_INSTITUTION,
                                initial_products: [:identity])
    @access_token = @item['access_token']
  end

  def teardown
    @client.item.delete(@access_token)
  end

  def test_get
    response = @client.identity.get(@access_token)
    refute_empty(response['identity'])
  end

  def test_get_invalid_access_token
    assert_raises(Plaid::InvalidInputError) do
      @client.identity.get(BAD_STRING)
    end
  end
end
