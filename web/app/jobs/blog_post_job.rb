class BlogPostJob
  include Sidekiq::Job
  def perform(store_id)
    # Use the store_id to fetch data specific to this store
    orchestrator_service = OrchestratorService.new
    begin
      orchestrator_service.run_orchestrator([store_id])
    rescue => e
      Rails.logger.error("Error running orchestrator for store ID #{store_id}: #{e.message}")
    end
  end
end
