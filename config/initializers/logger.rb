Rails.application.configure do
  file_looger = Logger.new(Rails.root.join("log", "#{Rails.env}.log").to_s)
end