json.array!(@champions) do |champion|
  json.extract! champion, :id, :name, :description, :tags
  json.url champions_url(champion, format: :json)
end
