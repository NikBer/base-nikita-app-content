class OrchestratorService
  def run_orchestrator(store_ids)
    store_ids.each do |store_id|
      create_blog_post_service = CreateBlogPostService.new
      create_blog_post_service.create_empty_blog_post(store_id)

      post_populator_service = PostPopulatorService.new
      blog_posts = SeoBlogPost.where(store_id: store_id)
      blog_posts.each do |blog_post|
        post_populator_service.populate_blog_post(store_id, blog_post.post_ID)
      end

      blog_post_publisher_service = BlogPostPublisherService.new
      blog_posts.each do |blog_post|
        blog_post_publisher_service.publish_blog_post(blog_post)
      end
    end
  end
end
