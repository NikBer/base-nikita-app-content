class BlogIdFetcherJob < ActiveJob::Base
  
    def perform(store_id)
      # Find the store
      store = Store.find(store_id)
  
      # Return if the blog_id is already set
      return if store.blog_id.present?
  
      # Find the corresponding shop for authentication
      shop = Shop.find_by(shopify_domain: store.shopify_domain)
  
      # Create a new ShopifyAPI session
      session = ShopifyAPI::Session.new(domain: shop.shopify_domain, token: shop.shopify_token, api_version: shop.api_version)
      ShopifyAPI::Base.activate_session(session)
  
      # Fetch the list of blogs
      blogs = ShopifyAPI::Blog.find(:all)
  
      # Set the store's blog_id to the ID of the last blog in the list
      store.update!(blog_id: blogs.last.id)
    end
  end
  