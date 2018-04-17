JSONAPI.configure do |config|
  # built in key format options are :underscored_key, :camelized_key and :dasherized_key
  config.json_key_format = :underscored_key

  # built in paginators are :none, :offset, :paged
  config.default_paginator = :offset
  config.default_page_size = 100
  config.maximum_page_size = 1000
end
