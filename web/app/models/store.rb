class Store < ApplicationRecord
    validates :shopify_domain, presence: true
    has_many :seo_blog_posts
end
