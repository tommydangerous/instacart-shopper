class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def permitted
    params.require(controller_name.singularize.to_sym).permit permitted_params
  end

  def stringify_single_error(errors)
    error = errors.first
    error[0].to_s.split("_").join(" ").capitalize + " #{error[1]}"
  end
end
