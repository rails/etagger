require 'active_support/concern'
require 'active_support/core_ext/class/attribute'

module Etagger
  extend ActiveSupport::Concern

  included do
    class_attribute :etaggers
    self.etaggers = []
  end

  module ClassMethods
    def etag(&etagger)
      self.etaggers += [etagger]
    end
  end

  def fresh_when(record_or_options, additional_options = {})
    super revise_etag(record_or_options, additional_options)
  end

  private
    def revise_etag(options, additional_options = nil)
      if !options.is_a?(Hash)
        last_modified = options.respond_to?(:updated_at) ? options.updated_at : nil
        revise_etag({ etag: options, last_modified: last_modified }.merge(additional_options))
      elsif etag = options[:etag]
        etags = etaggers.map { |etagger| instance_exec &etagger }.compact
        options.merge etag: [etag, *etags]
      else
        options
      end
    end
end
