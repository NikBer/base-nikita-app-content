class BlogIdFetcherJob < ActiveJob::Base
  
  def perform(store_id)
    # Find the store
    store = Store.find(store_id)

    # Return if the blog_id is already set
    return if store.blog_id.present?

# Find the corresponding shop for authentication
shop = Shop.find_by(shopify_domain: store.shopify_domain)

# Create a new Shopify client using the shop's token
client = ShopifyAPI::Clients::Rest::Admin.new(session: shop.shopify_token)


    # Fetch the list of blogs using the new client
    response = client.get(path: "blogs")
    blogs = response.body

    # Set the store's blog_id to the ID of the last blog in the list
    store.update!(blog_id: blogs.last["id"])
  end
end
