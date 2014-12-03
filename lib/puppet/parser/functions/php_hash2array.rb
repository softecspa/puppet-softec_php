module Puppet::Parser::Functions
  newfunction(:php_hash2array, :type => :rvalue, :doc => <<-EOS
When given a hash this function return array in form ['key1 value1', 'key2 value2' ...].
EOS
  ) do |args|

    input_hash = args[0]
    unless input_hash.is_a?(Hash)
      raise(Puppet::ParseError, 'php_hash2array(): Requires hash as parameter to work with')
    end

    result = Array.new

    input_hash.each do |key, val|
      elem = key.to_s+' '+val.to_s
      result << elem
    end

    return(result)
  end
end
