class Users::SessionsController < Devise::SessionsController

  # before_filter :force_https, except:[:destroy]

  private

  # Avoid messages like "you've been successfully logged in"
  # def set_flash_message(*args, &block)
  # end

end
