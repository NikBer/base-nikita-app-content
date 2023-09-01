class BlogPostPublisherService
    def publish_blog_post(blog_post)
      # Create a new ShopifyAPI session
      session = ShopifyAPI::Session.new(domain: blog_post.store.shopify_domain, token: blog_post.store.shopify_token, api_version: '2022-01')
      ShopifyAPI::Base.activate_session(session)
  
      # Create a new article with the blog post's content
      article = ShopifyAPI::Article.new(
        blog_id: blog_post.store.blog_id,
        title: blog_post.title,
        body_html: blog_post.content,
        published: true
      )
  
      # Save the article to Shopify
      if article.save
        Rails.logger.info("Successfully published blog post ID #{blog_post.id} to Shopify store ID #{blog_post.store_id}")
      else
        Rails.logger.error("Failed to publish blog post ID #{blog_post.id} to Shopify store ID #{blog_post.store_id}: #{article.errors.full_messages.join(", ")}")
      end
    rescue => e
      Rails.logger.error("Error publishing blog post ID #{blog_post.id} to Shopify store ID #{blog_post.store_id}: #{e.message}")
    end
  end
  