require 'spec_helper'

describe DevController do
  render_views true

  describe "when no user is logged in" do
    it "always stores the chosen locale in the session" do
      expect(controller.session_locale).to be_nil
      get :locales, "#{LocaleAware::LOCALE_PARAM}" => 'es'
      expect(controller.session_locale).to eq('es')
    end

    it "has english as default language" do
      expect(controller.session_locale).to be_nil
      get :locales

      expect(controller.params_locale).to  be_nil
      expect(controller.user_locale).to    be_nil
      expect(controller.session_locale).to eq(:en)
      expect(controller.browser_locale).to be_nil
      expect(response.body).to have_content(I18n.t('dev.locales_intro', locale:'en'))
    end

    it "can read the locale from the url param" do
      expect(controller.session_locale).to be_nil
      get :locales, "#{LocaleAware::LOCALE_PARAM}" => 'es'

      expect(controller.params_locale).to  eq('es')
      expect(controller.user_locale).to    be_nil
      expect(controller.session_locale).to eq('es')
      expect(controller.browser_locale).to be_nil
      expect(response.body).to have_content(I18n.t('dev.locales_intro', locale:'es'))
    end

    it "can read the locale from the browser" do
      expect(controller.session_locale).to be_nil
      @request.headers["Accept-Language"] = "es-ES"
      get :locales

      expect(controller.params_locale).to  be_nil
      expect(controller.user_locale).to    be_nil
      expect(controller.session_locale).to eq('es')
      expect(controller.browser_locale).to eq('es')
      expect(response.body).to have_content(I18n.t('dev.locales_intro', locale:'es'))
    end

    it "can read the locale from the session" do
      expect(controller.session_locale).to be_nil

      get :locales, "#{LocaleAware::LOCALE_PARAM}" => 'es'
      expect(controller.session_locale).to eq('es')

      get :locales
      expect(controller.params_locale).to  be_nil
      expect(controller.user_locale).to    be_nil
      expect(controller.session_locale).to eq('es')
      expect(controller.browser_locale).to be_nil
      expect(response.body).to have_content(I18n.t('dev.locales_intro', locale:'es'))
    end
  end

  describe "when a user is logged in" do
    before :each do
      @user = FactoryGirl.build(:user)
      allow(controller).to receive(:current_user).and_return(@user)
    end
    describe "if the user doesnt have a locale persisted" do
      it "persists the locale in the user model" do
        @user.locale = nil
        expect(controller.user_locale).to be_nil
        get :locales

        expect(controller.user_locale).to eq(:en)
        expect(response.body).to have_content(I18n.t('dev.locales_intro', locale:'en'))
      end
    end

    describe "if the user has a locale persisted" do
      it "uses the user locale (unless a param is passed)" do
        @user.locale = 'es'
        expect(controller.user_locale).to eq('es')
        get :locales

        expect(controller.user_locale).to eq('es')
        expect(response.body).to have_content(I18n.t('dev.locales_intro', locale:'es'))
      end
    end
  end

end
