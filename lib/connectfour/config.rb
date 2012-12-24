require 'config.yaml'

module ConnectFour
  class Config
    def initialize(config_file = 'config.yaml')
      config = YAML.load_file(config_file)
      config.each do |key, value|
        class_eval { attr_reader key }
        instance_variable_set("@#{key}", value)
      end
    end
  end
end