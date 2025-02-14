module ActiveRecord
  module JSONB
    module Associations
      module Association #:nodoc:
        def creation_attributes
          return super unless reflection.options.key?(:foreign_store)

          attributes = {}
          jsonb_store = reflection.options[:foreign_store]
          attributes[jsonb_store] ||= {}
          attributes[jsonb_store][reflection.foreign_key] =
            owner[reflection.active_record_primary_key]

          attributes
        end

        # rubocop:disable Metrics/AbcSize
        def scope_for_create
          super.tap do |scope|
            next unless options.key?(:foreign_store)
            scope[options[:foreign_store].to_s] ||= {}
            scope[options[:foreign_store].to_s][reflection.foreign_key] =
              owner[reflection.active_record_primary_key]
          end
        end
        # rubocop:enable Metrics/AbcSize
      end
    end
  end
end
