class ApiController < ActionController::API
  include Pundit

  def_param_group :post do
    param :post, Hash, :action_aware => true do
      param :title, String, :required => true
      param :description, String, :required => true
      param :user_id, Integer, :required => true
    end
  end

end