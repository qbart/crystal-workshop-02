macro throws(klass)
  class {{klass}} < Exception; end
end
