# frozen_string_literal: true

module Webpacker
  module Backport
    module_function

    def deep_symbolize_keys(hash)
      _deep_transform_keys_in_object(hash) { |key| key.to_sym rescue key }
    end

    # Support methods for deep transforming nested hashes and arrays.
    def _deep_transform_keys_in_object(object, &block)
      case object
      when Hash
        object.each_with_object({}) do |(key, value), result|
          result[yield(key)] = _deep_transform_keys_in_object(value, &block)
        end
      when Array
        object.map { |e| _deep_transform_keys_in_object(e, &block) }
      else
        object
      end
    end
  end
end
