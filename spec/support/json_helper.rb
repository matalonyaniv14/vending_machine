require "json"

class JsonHelper
  def self.write_json(file, data)
    File.write(file, data.to_json)
  end
end
