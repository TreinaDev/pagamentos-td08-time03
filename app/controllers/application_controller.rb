class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name, :cpf])
  end

    def after_sign_in_path_for(resource)
      return super if resource.is_a?(Admin) && resource.approved?

      sign_out(resource)
      flash[:alert] = 'Aguarde a aprovação do seu cadastro'
    end
end
