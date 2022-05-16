require "json"

class BaseRepository
  def initialize(path)
    @path = path
    @rows = []
    load
  end

  def all
    @rows
  end

  private

  def load
    data = JSON.parse(File.read(@path), symbolize_names: true)
    @rows = data.map { |row| model_klass.send(:new, row) }
  end

  def model_klass
    Object.const_get(self.class.name.split("Repository").join)
  end
end
