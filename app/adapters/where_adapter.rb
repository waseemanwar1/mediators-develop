class WhereAdapter
  def self.not_nil(hash={})
    new_hash = {}
    hash.map do |k, v|
      if v.kind_of?(Hash)
        result = WhereAdapter.not_nil(v)
        new_hash[k] = result if result.present?
      elsif v.kind_of?(FalseClass)
        new_hash[k] = v
      else
        new_hash[k] = v if v.present?
      end
    end
    new_hash
  end
end
