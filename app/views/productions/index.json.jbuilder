json.array!(@productions) do |production|
  json.extract! production, :id
  json.url production_url(production, format: :json)
end
