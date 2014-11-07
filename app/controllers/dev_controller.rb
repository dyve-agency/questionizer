require 'ostruct'
class DevController < ApplicationController
  before_filter :do_not_execute_in_production!
  before_filter :set_seo_vars

  def impersonate
    user = User.find(params.require(:user_id))
    sign_in(:user, user)
    redirect_to "/"
  end

  def locales
  end

  def access_denied
    raise CanCan::AccessDenied
  end

  def flash_messages
    flash[:alert]        = "I am a `alert` flash message"
    flash[:error]        = "I am a `error` flash message"
    flash[:notice]       = "I am a `notice` flash message"
    flash[:non_existent] = "I am a `not_existant` flash message"
  end

  def bootstrap_data
    @bootstrap_example_from_backend = {
      title:   'BootstrapData is working! :D',
      content: "This text is generated from the backend, serialized into json in the render, and recovered and showed by javascript"
    }
  end

  def send_test_mail
    user = OpenStruct.new(email: 'iamuser@railsblank.app')
    TestMailer.test(user).deliver
    redirect_to :back
  end

  private

  def do_not_execute_in_production!
    raise ActiveRecord::RecordNotFound if Rails.env.production?
  end

  def set_seo_vars(node=nil)
    case self.action_name.to_sym
    when :locales
      seo_vars[:title] = t('dev.locales_seo_title')
      seo_vars[:desc]  = t('dev.locales_intro')
    end
  end
end
