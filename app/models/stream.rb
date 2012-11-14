class Stream < Struct.new(:name, :title, :image, :preview)

  # Returns all streams from the cache
  def self.all
    items = REDIS.lrange "streams", 0, -1
    items.map do |item|
      json = JSON.parse(item)
      Stream.new(json["name"], json["title"], json["image"], json["preview"])
    end
  end
end
