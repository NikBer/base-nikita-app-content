class PromptRunnerService
    LOGIC_OPTIONS = ['best_selling', 'newest', 'oldest', 'most_inventory'].freeze
  
    def run_prompts(store_id, post_id)
        selected_logic = LOGIC_OPTIONS.sample
        product_names = select_products(store_id, selected_logic)
      
        content_prompt = "Write an SEO-optimized 1800 word blog post with a SEO-optimized title and summary about these products: #{product_names.join(', ')}. Organize your response with the title first, the post itself second and the summary third and each of these sections are to be split by /n/n/n/n"
        
        chat_gpt_api_service = ChatGPTApiService.new
        
        prompt_starttime = DateTime.now
        response = chat_gpt_api_service.generate_prompt_response(content_prompt)
        prompt_finishtime = DateTime.now
      
        # Assuming the response from ChatGPTApiService is a string that contains the title, body, and summary
        # separated by "/n/n/n/n", we can split the response into these parts.
        title, body, summary = response.split("/n/n/n/n")
      
        # Save each part as a separate prompt record
        title_prompt_id = create_prompt(store_id, content_prompt, title, 'title', prompt_starttime, prompt_finishtime)
        body_prompt_id = create_prompt(store_id, content_prompt, body, 'body', prompt_starttime, prompt_finishtime)
        summary_prompt_id = create_prompt(store_id, content_prompt, summary, 'summary', prompt_starttime, prompt_finishtime)
      
        { prompt_id_title: title_prompt_id, prompt_id: body_prompt_id, prompt_id_summary: summary_prompt_id }
      rescue => e
        log_error("Error running prompts for store ID #{store_id} and post ID #{post_id}: #{e.message}")
        nil
      end
      
    private
  
    def select_products(store_id, logic)
      case logic
      when 'best_selling'
        products = ProductsDb.where(store_id: store_id).order(sales: :desc).limit(20)
      when 'newest'
        products = ProductsDb.where(store_id: store_id).order(shopify_created_at: :desc).limit(10)
      when 'oldest'
        products = ProductsDb.where(store_id: store_id).order(shopify_created_at: :asc).limit(10)
      when 'most_inventory'
        products = ProductsDb.where(store_id: store_id).order(inventory: :desc).limit(10)
      end
      products.pluck(:product_name).sample(4)
    rescue => e
      log_error("Error selecting products for store ID #{store_id} with logic #{logic}: #{e.message}")
      []
    end
  
    def create_prompt(store_id, prompt, response, type, prompt_starttime, prompt_finishtime)
      prompt_record = Prompt.create!(
        store_ID: store_id,
        prompt: prompt,
        response: response,
        type: type,
        prompt_starttime: prompt_starttime,
        prompt_finishtime: prompt_finishtime
      )
      prompt_record.id
    rescue => e
      log_error("Error creating prompt for store ID #{store_id} and type #{type}: #{e.message}")
      nil
    end
  
    def log_error(message)
      Rails.logger.error("[Error] #{message}")
    end
  end
  