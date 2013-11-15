class ASINExtractor
  # Parses provided url to extract ASIN and returns it. Returns nil if no ASIN found.
  def self.extract(str)
    return nil unless asin_array = str.match(/\/([A-Z0-9]{10})/)
    asin_array.captures.first
  end
end