module LayoutsHelper
  def dev_tools
    if Rails.env.development? || Rails.env.staging?
      capture do
        render partial:"shared/dev_tools"
      end
    end
  end

  def head_tags
      %{<head>
      #{ title }
      #{ meta_tags }
      #{ csrf_meta_tag }
      #{ favicons }
      #{ split_stylesheet_link_tag "application", :media => "all" }
      <!--[if lt IE 10]>#{stylesheet_link_tag 'legacy/ie9'}<![endif]-->
      #{ google_analytics }
      #{ google_fonts  }
      </head>}.html_safe
  end

  def body_css_classes
    classes = []
    classes << controller.controller_name
    classes << "#{controller.controller_name}-#{controller.action_name}"
    classes << controller.send(:_layout)
    classes <<  "mobile" if browser.mobile?
    classes.join(" ")
  end

  def bootstrap_data
    capture_haml do
      haml_tag :div, id:"bootstrap", class:"hidden" do
        haml_concat content_for(:bootstrap)
      end
    end
  end

  def title
    "<title>#{seo_vars[:title]}</title>".html_safe
  end

  def meta_tags(allow_index=true)
    meta =  "<meta http-equiv='Content-type' content='text/html; charset=utf-8' /> \n"
    meta << "<meta name='robots' content='noindex,noarchive,nofollow' /> \n" unless allow_index
    meta << "<meta name=\"Description\" content=\"#{seo_vars[:meta_desc]}\" /> \n"
    meta << "<meta http-equiv='Content-Language' content='#{seo_vars[:meta_lang]}' /> \n"
    meta << '<meta http-equiv="X-UA-Compatible" content="IE=edge">'
    meta << '<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">'

    meta.html_safe
  end

  def favicons
    return # remove when favicons are added to the project

    # http://www.jonathantneal.com/blog/understand-the-favicon/
    # http://stackoverflow.com/questions/2997437/what-size-should-apple-touch-icon-png-be-for-ipad-and-iphone-4
    #
    icons=""
    # (.. Because retina icons are exactly double the size of the standard icons we really only need to make 2 icons: 114 x 114 and 144 x 144)
    # Standard iPhone -->
    icons << favicon_link_tag("favicons/favicon-114.png", rel:"apple-touch-icon", sizes:"57x57")
    # Retina iPhone -->
    icons << favicon_link_tag("favicons/favicon-114.png", rel:"apple-touch-icon", sizes:"114x144")
    # Standard iPad -->
    icons << favicon_link_tag("favicons/favicon-144.png", rel:"apple-touch-icon", sizes:"72x72")
    # Retina iPad -->
    icons << favicon_link_tag("favicons/favicon-144.png", rel:"apple-touch-icon", sizes:"144x144")

    # 96x96 PNG
    icons << favicon_link_tag("favicons/favicon-96.png", rel:"icon")

    # Resolutions emmbeded: 16x16, 24x24, 32x32, 64x64
    # http://www.xiconeditor.com/
    icons << "<!--[if IE]>#{ favicon_link_tag("favicons/favicon.ico", rel:"shortcut icon")}<![endif]-->"

    # IE10 + Windows 8,, 144x144 transparent
    icons << %{
    <meta name="application-name" content="pagebox" />
    <meta name="msapplication-starturl" content="https://www.pagebox.es" />
    <meta name="msapplication-TileImage" content="#{path_to_image('favicons/favicon-w8.png')}" />
    <meta name="msapplication-TileColor" content="#153662" />
    }

    icons.html_safe
  end

  def google_fonts
    return # remove when favicons are added to the project
    if Rails.env.production?
      capture_haml do
        haml_tag :link, href:'//fonts.googleapis.com/css?family=Droid+Sans:400,700', rel:'stylesheet', type:'text/css'
      end
    else
      # Based on https://gist.github.com/kevindew/4961694#file-gistfile1-js
      # Meant to load the font asynchronously
      %{<script type='text/javascript'>
          WebFontConfig={google:{families:["Droid+Sans:400,700:latin"]}}; (function(){var e=document.createElement("script");e.src=("https:"==document.location.protocol?"https":"http")+"://ajax.googleapis.com/ajax/libs/webfont/1/webfont.js";e.type="text/javascript";e.async="true";var t=document.getElementsByTagName("script")[0];t.parentNode.insertBefore(e,t);setTimeout(function(){if(!("WebFont"in window)){document.getElementsByTagName("html")[0].className+=" wf-fail"}},500)})()
        </script>}.html_safe
    end
  end

  def google_analytics
    return # remove when analytics is added to the project
    return if Rails.env.development?
    google_script_template("UA-XXXXXXXX-1", "domain.com").html_safe
  end

  def google_script_template(ua, domain)
    <<-EOS
    <script type="text/javascript">

      var _gaq = _gaq || [];
      _gaq.push(['_setAccount', '#{ua}']);
      _gaq.push(['_setDomainName', '#{domain}']);
      _gaq.push(['_trackPageview']);

      (function() {
        var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
      })();

    </script>
    EOS
  end

end
