if defined? Rack::Cors
  Rails.configuration.middleware.insert_before 0, Rack::Cors do
    allow do
      origins %w[
                http://autoservicehaarlem.nl
                http://www.autoservicehaarlem.nl
            ]
      resource '/assets/*'
    end
  end
end