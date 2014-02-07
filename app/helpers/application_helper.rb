module ApplicationHelper
  def active_if(method)
    params[:action] == method.to_s ? 'active' : nil
  end
end
