environment_settings = YAML.load_file('./config/application.yml')[Rails.env]

environment_settings.each do |key, value|
  ENV[key] ||= value
end