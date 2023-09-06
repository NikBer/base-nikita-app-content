class BlogPostPublisherService
    def publish_blog_post(blog_post)
      # Find the corresponding shop for authentication
      shop = Shop.find_by(shopify_domain: blog_post.store.shopify_domain)
      
      # Create a new Shopify client using the shop's token
      client = ShopifyAPI::Clients::Rest::Admin.new(session: shop.shopify_token)

      # Build your post request body for the article
      body = {
        article: {
          title: blog_post.title,
          body_html: blog_post.content,
          published: true
        }
      }

# Use `client.post` to send your request to the specified Shopify Admin REST API endpoint.
response = client.post({
  path: "blogs/#{blog_post.store.blog_id}/articles",
  body: body
})

# Check the response for success
if response.code == 201
  Rails.logger.info("Successfully published blog post ID #{blog_post.id} to Shopify store ID #{blog_post.store_id}")
else
  Rails.logger.error("Failed to publish blog post ID #{blog_post.id} to Shopify store ID #{blog_post.store_id}: #{response.body['errors']}")
end

    rescue => e
      Rails.logger.error("Error publishing blog post ID #{blog_post.id} to Shopify store ID #{blog_post.store_id}: #{e.message}")
    end
  end
  