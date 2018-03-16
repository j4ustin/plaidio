require 'date'

module Plaid
  # Internal: Converts date objects to strings if needed.
  #
  # Takes in a string or a Date object and performs necessary operations to
  # return a string representation of the Date
  #
  # date - Date in Date object form or string form (YYYY-MM-DD)
  #
  # Returns a String with an ISO-8601 date.
  def self.convert_to_date_string(date)
    date.is_a?(String) ? date : date.to_date.strftime('%Y-%m-%d')
  end

  # Public: Class used to call the Transactions product.
  class Transactions < BaseProduct
    # Public: Get information about transactions
    #
    # Does a POST /transactions/get call which gives you high level account data along
    # with transactions from all accounts contained in the access_token's item
    #
    # access_token - access_token who's item to fetch transactions for
    # start_date   - Start of query for transactions
    # end_date     - End of query for transactions
    # account_ids  - Specific account ids to fetch balances for (optional)
    # count        - Amount of transactions to pull (optional)
    # offset       - Offset to start pulling transactions (optional)
    # options      - Additional options to merge into API request
    #
    # Returns a parsed JSON listing information on transactions
    def get(access_token, start_date, end_date,
            account_ids: nil, count: nil, offset: nil, options: nil)

      options_payload = {}
      options_payload[:account_ids] = account_ids unless account_ids.nil?
      options_payload[:count] = count unless count.nil?
      options_payload[:offset] = offset unless offset.nil?
      options_payload.merge!(options) unless options.nil?

      post_with_auth('transactions/get',
                     GetResponse,
                     access_token: access_token,
                     start_date: Plaid.convert_to_date_string(start_date),
                     end_date: Plaid.convert_to_date_string(end_date),
                     options: options_payload)
    end

    class GetResponse < Models::BaseResponse
      property :item, coerce: Models::Item
      property :accounts, coerce: Array[Models::Account]
      property :transactions, coerce: Array[Models::Transaction]

      # Public: The String last updated time (if available).
      property :last_updated

      # Public: The Numeric total transactions count.
      property :total_transactions
    end
  end
end
