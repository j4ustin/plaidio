module Plaid
  # Public: Class used to call the SandboxItem sub-product.
  class SandboxItem < BaseProduct
    # Public: Resets sandbox item login.
    #
    # Does a POST /sandbox/item/reset_login call.
    #
    # access_token - access_token which item to reset login for.
    #
    # Returns a ResetLoginResponse object.
    def reset_login(access_token)
      post_with_auth 'sandbox/item/reset_login',
                     ResetLoginResponse,
                     access_token: access_token
    end

    # Public: Response for /sandbox/item/reset_login.
    class ResetLoginResponse < Models::BaseResponse
      ##
      # :attr_reader:
      # Public: The Boolean reset success flag.
      property :reset_login
    end
  end

  # Public: Class used to call the Sandbox product.
  class Sandbox < BaseProduct
    ##
    # :attr_reader:
    # Public: The Plaid::SandboxItem product accessor.
    subproduct :sandbox_item
  end
end
