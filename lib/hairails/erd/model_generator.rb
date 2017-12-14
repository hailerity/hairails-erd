module Hairails
  module Erd
    class ModelGenerator
      def initialize model
        @model = model
      end

      # TODO: Check model fields validity
      def generate
        fields = @model.fields.map do |k, v|
          k = k.downcase.strip
          v = v.downcase.strip
          if v == 'ref'
            v = 'references'
            # TODO: Handle custom foreign key
            k = k.gsub /_id$/, ''
          end

          [k, v]
        end.to_h.reject do|k, v|
          k == 'id'
        end.map do |k, v|
          "#{k}:#{v}"
        end.join(' ')

        cmd = "bundle exec rails g model #{@model.name} #{fields}"
        puts "\nExecute: #{cmd}"

        system(cmd)
      end
    end
  end
end
