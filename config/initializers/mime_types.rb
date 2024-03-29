JSONAPI_MEDIA_TYPE = 'application/vnd.api+json'

Mime::Type.register JSONAPI_MEDIA_TYPE, :jsonapi

ActionController::Renderers.add :jsonapi do |json, options|
  json = json.to_json(options) unless json.is_a?(String)
  self.content_type ||= Mime[:jsonapi]
  self.response_body = json
end

ActionDispatch::Request.parameter_parsers[:jsonapi] = lambda do |body|
  data = JSON.parse(body)
  data = { _json: data } unless data.is_a?(Hash)
  data.with_indifferent_access
end
