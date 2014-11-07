module AppNotificationsHelper

  def errors_list(model)
    if model.errors.any?
      str= %{
        <div class="error-messages alert alert-danger">
          <h3>#{I18n.t('shared.errors', count:model.errors.count)}</h3>
          <ul>#{model.errors.full_messages.map{|msg| content_tag(:li, msg)}.join}</ul>
        </div>
      }.html_safe
    end
    str
  end

  # taken from https://github.com/hisea/devise-bootstrap-views/blob/master/lib/devise_bootstrap_views_helper.rb
  def bootstrap_devise_error_messages!
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t('errors.messages.not_saved',
      count: resource.errors.count,
      resource: resource.class.model_name.human.downcase)

    html = <<-HTML
    <div class="alert alert-danger alert-block errors">
      <button type="button" class="close" data-dismiss="alert">x</button>
      <h5>#{sentence}</h4>
      #{messages}
    </div>
    HTML

    html.html_safe
  end

  def flash_type_to_bootstrap_class(type)
    case type.to_sym
      when :alert
        "alert-warning"
      when :error
        "alert-danger"
      when :notice
        "alert-info"
      else
        "alert-info"
    end
  end
end
