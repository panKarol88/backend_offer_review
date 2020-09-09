class ApplicationController < ActionController::API
  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = case @role
                      when 'salesman'
                        Salesman.find(@decoded[:salesman_id])
                      when 'admin'
                        # TODO
                        # Admin.find(@decoded[:admin_id])
                      when 'client'
                        Client.find(@decoded[:client_id])
                      else
                        raise 'Unsupported role.'
                      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end
