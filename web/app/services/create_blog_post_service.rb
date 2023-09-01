class CreateBlogPostService
    def create_empty_blog_post(store_id)
      blog_post = SeoBlogPost.create(store_id: store_id, date_created: DateTime.now)
  
      if blog_post.persisted?
        log_success("Blog post created with ID #{blog_post.id} for store ID #{store_id}")
      else
        log_error("Failed to create blog post for store ID #{store_id}")
      end
    rescue => e
      log_error("Error creating blog post for store ID #{store_id}: #{e.message}")
    end
  
    private
  
    def log_success(message)
      Rails.logger.info("[Success] #{message}")
    end
  
    def log_error(message)
      Rails.logger.error("[Error] #{message}")
    end
  end
  