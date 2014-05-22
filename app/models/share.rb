class Share < ActiveRecord::Base
  is_impressionable
  belongs_to :user
  validates_presence_of :content_url, :header_url, :header_content, :header_background_color, :header_text_color
  default_scope { order(:created_at => :desc) }

  validates_url_format_of :content_url, :message => 'is not a valid url'
  validates_url_format_of :header_url, :message => 'is not a valid url'

  COLOR_REGEX = /\A\s*#([0-9a-fA-F]{3}){1,2}\s*\Z/
  validates_format_of :header_background_color, with: COLOR_REGEX
  validates_format_of :header_text_color, with: COLOR_REGEX

  def views
    impressionist_count(:message => "page_view")
  end

  def clicks
    impressionist_count(:message => "header_click")
  end
end
