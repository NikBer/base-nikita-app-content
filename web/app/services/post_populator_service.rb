class PostPopulatorService
    def populate_blog_post(store_id, post_id)
      prompt_data = PromptRunnerService.new.run_prompts(store_id, post_id)
  
      blog_post = SeoBlogPost.find_by(store_id: store_id, post_ID: post_id)
      if blog_post
        blog_post.update(
          prompt_id_title: prompt_data[:prompt_id_title],
          prompt_id: prompt_data[:prompt_id],
          prompt_id_summary: prompt_data[:prompt_id_summary]
        )
        log_success("Blog post populated with prompts for store ID #{store_id} and post ID #{post_id}")
      else
        log_error("Blog post not found for store ID #{store_id} and post ID #{post_id}")
      end
    rescue => e
      log_error("Error populating blog post for store ID #{store_id} and post ID #{post_id}: #{e.message}")
    end
  
    private
  
    def log_success(message)
      Rails.logger.info("[Success] #{message}")
    end
  
    def log_error(message)
      Rails.logger.error("[Error] #{message}")
    end
  end
  