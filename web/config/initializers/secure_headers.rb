# config/initializers/secure_headers.rb

SecureHeaders::Configuration.default do |config|
  config.csp = {
    default_src: %w('self'),
    frame_ancestors: %w('self' https://admin.shopify.com),
    frame_src: %w('self' p.shopify.com *.shopifyapps.com *.myshopify.com *.myshopify.com https://* shopify-pos://* hcaptcha.com *.hcaptcha.com blob: http://localhost:*')
  }
  
  # Other CSP directives and configurations
end