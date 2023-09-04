class JobsController < ApplicationController
    def trigger_blog_id_fetcher
        BlogIdFetcherJob.perform_later
        render json: { status: 'success', message: 'Blog ID Fetcher Job Triggered' }, status: :ok
    end

    def trigger_blog_post_job
        BlogPostJob.perform_later
        render json: { status: 'success', message: 'Blog Post Job Triggered' }, status: :ok
    end

    def trigger_fetch_shopify_data_worker
        FetchShopifyDataWorker.perform_later
        render json: { status: 'success', message: 'Fetch Shopify Data Worker Triggered' }, status: :ok
    end
end
