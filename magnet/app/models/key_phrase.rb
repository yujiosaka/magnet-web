class KeyPhrase
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  store_in :collection => "key_phrase_summaries"
end

