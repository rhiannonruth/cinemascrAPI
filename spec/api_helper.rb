def api_get(action)
  get "/api/v1/#{action}", {}
  JSON.parse(response.body)
end
