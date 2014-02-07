class Share < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :content_url, :header_url, :header_content
  default_scope order('created_at DESC')
end
