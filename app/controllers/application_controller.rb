class ApplicationController < ActionController::API
  def authorize_request(role:)
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      decoded = JsonWebToken.decode(header)
      # TODO rather create one model for all users (or only for admin users: salesman, admin)
      current_user = case role
                      when 'salesman'
                        Salesman.find_by_id(decoded[:salesman_id])
                      when 'admin'
                        # TODO
                        # Admin.find_by_id(@decoded[:admin_id])
                      when 'client'
                        Client.find_by_id(decoded[:client_id])
                      else
                        raise 'Unsupported role.'
                     end

      raise ActiveRecord::RecordNotFound if current_user.nil?
      true
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end
