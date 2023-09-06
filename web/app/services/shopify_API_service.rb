class ShopifyApiService
    # Initialization of the ShopifyAPIService.
    # It sets the ShopifyAPI::Base.site with the provided shop_domain and token.
    # Error handling is provided for initialization errors.
    def initialize(store_id)
      shop = Shop.find(store_id)
      @client = ShopifyAPI::Clients::Rest::Admin.new(session: shop.shopify_token)      
      
    rescue => e
      Rails.logger.error("Error initializing ShopifyAPIService for store ID #{store_id}: #{e.message}")
    end
  
    # This method fetches all the products from the Shopify store using pagination.
    # It starts from page 1 and fetches products in batches of 250 (the maximum allowed by Shopify API).
    # It keeps fetching the next page until there are no more products.
    # Error handling is provided for issues that might occur while fetching the products.
    def get_products
      products = []
      page = 1
      loop do
        response = @client.get(path: "products", query: { limit: 250 })
        
        break unless response.body.present?
        products += response.body
        break unless response.next_page_info
        response = @client.get(path: "products", query: { limit: 250, page_info: response.next_page_info })
        
      end
      products
    rescue => e
      puts "Error fetching products: #{e.message}"
      []
    end
  
    # This method fetches all the orders from the Shopify store using pagination.
    # It starts from page 1 and fetches orders in batches of 250 (the maximum allowed by Shopify API).
    # It keeps fetching the next page until there are no more orders.
    # It then maps over the fetched orders to construct sales data for each order.
    # Error handling is provided for issues that might occur while fetching the orders and constructing the sales data.
    def get_sales_data
      orders = []
      page = 1
      loop do
        response = @client.get(path: "orders", query: { limit: 250 })
        
        break unless response.body.present?
        orders += response.body
        break unless response.next_page_info
        response = @client.get(path: "orders", query: { limit: 250, page_info: response.next_page_info })
        
      end
  
      # Map over the fetched orders to construct sales data
      sales_data = orders.map do |order|
        {
          order_id: order.id,
          total_price: order.total_price,
          created_at: order.created_at,
          line_items: order.line_items.map do |item|
            {
              product_id: item.product_id,
              variant_id: item.variant_id,
              quantity: item.quantity,
              price: item.price
            }
          end
        }
      end
      sales_data
    rescue => e
      puts "Error fetching sales data: #{e.message}"
      []
    end
  end
  