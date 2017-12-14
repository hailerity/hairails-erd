module Hairails
  module Erd
    class SvgParser
      def initialize svg_path
        @svg_path = svg_path
      end

      def parse
        doc = Nokogiri::XML(svg_content)

        models = {}
        node = doc.root.children[1].children[0]
        stack = node_stack
        while node
          stack << node

          if stack.in_class?
            node = node.next
            model = parse_model(node)
            models[model.name] = model

            stack << nil
          elsif stack.in_relation?
            node = node.next
          else
            node = node.next
          end
        end

        models
      end

      private

      # Parse a model starting from a node
      def parse_model node
        model = Model.new

        # extract model name
        model.name = node.children[0].text
        model.fields = {}

        # extract model fields
        while (node = node.next) && node.name == 'g'
          text = node.children[0].text
          field, type = text[1..-1].split(':').map(&:strip)
          model.fields[field] = type
        end

        model
      end

      def svg_content
        File.read(@svg_path)
      end

      def node_stack
        stack = []
        stack.instance_eval do
          def in_class?
            path_names = (self[-4..-1] || []).compact.map(&:name)
            path_names == ['rect', 'rect', 'path', 'path']
          end

          def in_relation?
            path_names = (self[-3..-1] || []).compact.map(&:name)
            path_names == ['path', 'path', 'path']
          end
        end

        stack
      end
    end
  end
end
