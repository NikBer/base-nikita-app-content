class BlogPostsController < ApplicationController
    def index
        # Get the store_id from the current session
        store_id = session[:store_id]
    
        # Fetch all the blog posts for this store
        @blog_posts = SeoBlogPost.where(store_id: store_id)
        @day_of_week = Date.today.wday
      end
    def create
      # Get the store_id from the current session
      store_id = session[:store_id]
  
      # Enqueue the job with the store_id
      begin
        Sidekiq::BlogPostJob.perform_async(store_id)
      rescue => e
        Rails.logger.error("Error enqueuing blog post job for store ID #{store_id}: #{e.message}")
        return
      end
  
      # Redirect to a confirmation page
      redirect_to confirmation_path
    end
  end
  