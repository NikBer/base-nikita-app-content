# app/workers/fetch_shopify_data_worker.rb

class FetchShopifyDataWorker
    include Sidekiq::Job
  
    def perform
      Store.find_each do |store|
        service = ShopifyApiService.new(store.id)
        service.get_products
        service.get_sales_data
      end
    rescue => e
      Rails.logger.error("Error fetching Shopify data: #{e.message}")
    end
  end