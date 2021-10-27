ENV["ELASTICSEARCH_URL"] = "node01" if Rails.env.staging?
ENV["ELASTICSEARCH_URL"] = "node01" if Rails.env.production?
