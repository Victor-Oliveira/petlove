# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protected

  def redirect(target, internationalization, model)
    redirect_to(
      target,
      notice: t(
        internationalization,
        model: t("activerecord.models.#{model}.one")
      )
    )
  end

  def render_json(json, status)
    render json: json, status: status
  end
end
