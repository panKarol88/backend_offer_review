class User < ApplicationRecord
  self.abstract_class = true

  def self.authenticate(token)
    begin
      decoded = JsonWebToken.decode(token)
      # TODO rather create one model for all users (or only for admin users: salesman, admin)
      user = case self.class.name.downcase
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

      user
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end
