json.array!(@shares) do |share|
  json.extract! share, :id, :content_url, :header_url
  json.url share_url(share, format: :json)
end
