# frozen_string_literal: true

class ThemesController < AuthenticatedController

  def get_theme
    themes = ShopifyAPI::Theme.all
    @theme = themes.find { |t| t.role == 'main' }
  end

  def update_theme
      get_theme()
      create_whatsapp_file()
      themeHeader = ShopifyAPI::Asset.all(theme_id: @theme.id, asset: {"key" => "sections/header.liquid"}).first

      if themeHeader.value.include?("{% include 'whatsapp-icon' %}")
        # WhatsApp icon code already exists
        puts "WhatsApp icon code already exists in header.liquid file"
      else
        # WhatsApp icon code doesn't exist
        original_value = themeHeader.value
        new_value = original_value + "\n<!-- WhatsApp icon code -->{% include 'whatsapp-icon' %}"
        themeHeader.value = new_value
        themeHeader.save!
        puts "WhatsApp icon code added to header.liquid file"
      end

      render json: { success: true }, status: :ok
    rescue => e
      render json: { error: e.message }, status: :bad_request
  end

  def create_whatsapp_file
    data = JSON.parse(request.body.read)
    @mobile_number = data['phone_number']
    @msg_line = data['msg_line']
    @position = data['position']
    @icon_size = data['icon_size']
    @padding = data['padding']
    @padding_bottom = data['padding_bottom']
    asset = ShopifyAPI::Asset.new()
    asset.theme_id = @theme.id
    asset.key = 'snippets/whatsapp-icon.liquid'
    asset.attachment = asset.value = <<~LIQUID
      <style>
        #whatsapp-icon {
          position: fixed;
          z-index: 9999;
        }
        #whatsapp-icon:hover {
          animation-name: shake;
          animation-duration: 0.5s;
          animation-timing-function: ease-in-out;
          animation-iteration-count: 1;
        }
        @keyframes shake {
          0% { transform: translate(0, 0); }
          10%, 90% { transform: translate(-5px, 0); }
          30%, 70% { transform: translate(5px, 0); }
          50% { transform: translate(0, -5px); }
          60% { transform: translate(0, -2px); }
          80% { transform: translate(0, 2px); }
        }
        .icon-wrap {
          position: fixed;
          bottom: #{@padding_bottom}px;
          #{@position}: #{@padding}px;
          z-index: 1999;
        }
        
        .icon-wrap:hover {
          cursor: pointer;
          bottom: #{@padding_bottom / 2}px;
        }
        
        .box {
          display: none;
          position: relative;
          left: 0.5em;
          background-color: white;
          border: 3px solid #00E676;
          height: #{@icon_size}px;
          border-top-left-radius: 50%;
          border-bottom-left-radius: 50%;
        }
        
        .icon-wrap:hover .box {
          display: flex;
          align-items: center;
        }

        .text {
          padding-left: #{@icon_size}px;
          padding-right: #{@icon_size / 4}px;
        }
      </style>
      <div class="icon-wrap">
        <div id="whatsapp-icon">
          <a href="whatsapp://send?phone=#{@mobile_number}&text=#{@msg_line}" target="_blank" rel="noopener">
            <span><svg xmlns="http://www.w3.org/2000/svg" width="#{@icon_size}" height="#{@icon_size}" viewBox="0 0 39 39"><path fill="#00E676" d="M10.7 32.8l.6.3c2.5 1.5 5.3 2.2 8.1 2.2 8.8 0 16-7.2 16-16 0-4.2-1.7-8.3-4.7-11.3s-7-4.7-11.3-4.7c-8.8 0-16 7.2-15.9 16.1 0 3 .9 5.9 2.4 8.4l.4.6-1.6 5.9 6-1.5z"></path><path fill="#FFF" d="M32.4 6.4C29 2.9 24.3 1 19.5 1 9.3 1 1.1 9.3 1.2 19.4c0 3.2.9 6.3 2.4 9.1L1 38l9.7-2.5c2.7 1.5 5.7 2.2 8.7 2.2 10.1 0 18.3-8.3 18.3-18.4 0-4.9-1.9-9.5-5.3-12.9zM19.5 34.6c-2.7 0-5.4-.7-7.7-2.1l-.6-.3-5.8 1.5L6.9 28l-.4-.6c-4.4-7.1-2.3-16.5 4.9-20.9s16.5-2.3 20.9 4.9 2.3 16.5-4.9 20.9c-2.3 1.5-5.1 2.3-7.9 2.3zm8.8-11.1l-1.1-.5s-1.6-.7-2.6-1.2c-.1 0-.2-.1-.3-.1-.3 0-.5.1-.7.2 0 0-.1.1-1.5 1.7-.1.2-.3.3-.5.3h-.1c-.1 0-.3-.1-.4-.2l-.5-.2c-1.1-.5-2.1-1.1-2.9-1.9-.2-.2-.5-.4-.7-.6-.7-.7-1.4-1.5-1.9-2.4l-.1-.2c-.1-.1-.1-.2-.2-.4 0-.2 0-.4.1-.5 0 0 .4-.5.7-.8.2-.2.3-.5.5-.7.2-.3.3-.7.2-1-.1-.5-1.3-3.2-1.6-3.8-.2-.3-.4-.4-.7-.5h-1.1c-.2 0-.4.1-.6.1l-.1.1c-.2.1-.4.3-.6.4-.2.2-.3.4-.5.6-.7.9-1.1 2-1.1 3.1 0 .8.2 1.6.5 2.3l.1.3c.9 1.9 2.1 3.6 3.7 5.1l.4.4c.3.3.6.5.8.8 2.1 1.8 4.5 3.1 7.2 3.8.3.1.7.1 1 .2h1c.5 0 1.1-.2 1.5-.4.3-.2.5-.2.7-.4l.2-.2c.2-.2.4-.3.6-.5s.4-.4.5-.6c.2-.4.3-.9.4-1.4v-.7s-.1-.1-.3-.2z"></path></svg></span>
          </a>
        </div>
        <div class="box">
          <span class="text"> Ask a Question </span>
        </div>
      </div>
    LIQUID
    asset.save!
  end
end