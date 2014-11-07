class StaticController < ApplicationController
  layout :set_layout

  private

  def set_layout
    case action_name
    when 'dashboard_example' then "dashboard"
    else 'public'
    end
  end
end
