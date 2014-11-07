require 'http_accept_language'

module LocaleAware
  LOCALE_PARAM = '_locale'

  module ClassMethods
    def locale_param=(value)
      @@locale_param = value
    end

    def locale_param
      @@locale_param
    end

    def app_available_locales
      # @@app_available_locales ||= calculate_available_locales_from_translations
      @@app_available_locales ||= I18n.available_locales.map(&:to_s)
    end

    def calculate_available_locales_from_translations
      Dir.new("#{Rails.root}/config/locales/").entries.map {|x| x =~ %r|^([^.]*)\.yml$|; $1 }.compact
    end

    @@locale_param = LOCALE_PARAM
  end

  def self.included(base)
    base.extend(ClassMethods)
  end

  def set_locale
    locale =
      params_locale ||
      user_locale ||
      session_locale ||
      browser_locale

    locale = I18n.default_locale unless self.class.app_available_locales.include?(locale.to_s)

    I18n.locale = locale
    self.session_locale = locale
  end

  def params_locale
    params[self.class.locale_param]
  end

  def session_locale
    session[self.class.locale_param]
  end

  def session_locale=(value)
    session[self.class.locale_param] = value
  end

  def browser_locale
    http_accept_language.compatible_language_from(self.class.app_available_locales)
  end

  def user_locale
    current_user.try(:locale)
  end

  def set_user_locale_if_unset
    if current_user && !user_locale
      current_user.update_attribute(:locale, I18n.locale)
    end
  end
end
