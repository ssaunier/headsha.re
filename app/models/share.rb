class Share < ActiveRecord::Base
  is_impressionable
  belongs_to :user
  validates_presence_of :content_url, :header_url, :header_content
  default_scope { order(:created_at => :desc) }

  validates_url_format_of :content_url, :message => 'is not a valid url'
  validates_url_format_of :header_url, :message => 'is not a valid url'
end
