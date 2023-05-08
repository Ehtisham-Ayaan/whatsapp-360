# frozen_string_literal: true
# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy.
# See the Securing Rails Applications Guide for more information:
# https://guides.rubyonrails.org/security.html#content-security-policy-header

# Rails.application.configure do
#   config.content_security_policy do |policy|
    # policy.default_src :self, :http
    # policy.font_src    :self, :https, :data
    # policy.img_src     :self, :https, :data
    # policy.object_src  :none
    # policy.script_src  :self, :https, :unsafe_inline, :strict_dynamic
    # policy.style_src   :self, :https
    # policy.base_uri    :self
    # policy.frame_ancestors :self, 'https://admin.shopify.com p.shopify.com *.shopifyapps.com *.myshopify.com *.myshopify.com https://* shopify-pos://* hcaptcha.com *.hcaptcha.com blob: http://localhost:* https://34.207.159.176:3000'
    # Specify URI for violation reports
    # policy.report_uri "/csp-violation-report-endpoint"
  #   policy.default_src :none
  #   policy.script_src :self, 'cdn.shopify.com', 'shopify-assets.com'
  #   policy.connect_src :self, 'cdn.shopify.com', 'shopify-assets.com'
  #   policy.img_src :self, :data
  #   policy.style_src :self, 'cdn.shopify.com', :unsafe_inline
  #   policy.font_src :self, 'cdn.shopify.com'
  #   policy.base_uri :self
  #   policy.frame_ancestors :self, '*.myshopify.com', ''
  #   policy.frame_src :self, 'p.shopify.com', '*.shopifyapps.com', '*.myshopify.com', '*.myshopify.com', 'https://*', 'shopify-pos://*', 'hcaptcha.com', '*.hcaptcha.com', 'blob:', 'http://localhost:*'
  #   policy.block_all_mixed_content
  # end
#
#   # Generate session nonces for permitted importmap and inline scripts
  # config.content_security_policy_nonce_generator = ->(request) { request.session.id.to_s }
  # config.content_security_policy_nonce_directives = %w(script-src)
#
#   # Report violations without enforcing the policy.
  # config.content_security_policy_report_only = true
# end
