class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout "public"

  include LocaleAware
  before_filter :set_locale
  before_filter :set_user_locale_if_unset

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

  helper_method :seo_vars, :return_here_url

  private

  def return_here_url(query={})
    _return = Addressable::URI.parse(request.fullpath)
    _return.query_values = (HashWithIndifferentAccess.new(_return.query_values) || {}).merge(query)
    _return.scheme= request.scheme
    _return.host = request.host
    # _return.port = CONFIG[:"#{request.scheme}_port"]
    _return.to_s
  end

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      follow_return_to_or(format) do
        format.json{render :json => {redirect_to: "/"}}
        format.html{redirect_to "/", :alert => exception.message}
      end
    end
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render_404
  end

  def seo_vars
    @seo_vars ||= {
      :title => t('seo_default_title'),
      :meta_desc => t('seo_default_desc'),
      :meta_lang => I18n.locale
    }
  end

  def render_404
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404.html", :status => :not_found, :layout=>false }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end

  # example of use, write this in your controller:
  #   follow_return_to_or(f) do
  #     f.html { redirect_to collection_path(@entry.collection_id) }
  #     f.json { render :show }
  #   end
  def follow_return_to_or(f, &block)
    url =  params[:return_to_url]
    if url
      f.html{redirect_to url}
      f.json{render :json => {redirect_to:url}}
    else
      block.call
    end
  end

  def authenticate_user_and_return_to!
    return if current_user
    redirect_to new_user_session_path(:return_to_url=>request.fullpath)
  end

  def https_redirect(use_https)
    unless Rails.env.test?
      if request.ssl? && !use_https || !request.ssl? && use_https
        protocol = request.ssl? ? "http" : "https"
        # if you need to specify http/https ports other than the default 80/443
        #port = request.ssl? ? CONFIG[:http_port] : CONFIG[:https_port]
        flash.keep
        redirect_to protocol: "#{protocol}://",  port:port, status: :moved_permanently, params:request.query_parameters
        # if you need to specify http/https ports other than the default 80/443
        # redirect_to protocol: "#{protocol}://",  port:port, status: :moved_permanently, params:request.query_parameters
      end
    end
  end

  def force_https
    https_redirect(true)
  end

  def force_http
    https_redirect(false)
  end

end
