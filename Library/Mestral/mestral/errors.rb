# This code is free software; you can redistribute it and/or modify it under
# the terms of the new BSD License.
#
# Copyright (c) 2013, Sebastian Staudt

module Mestral

  class HookletNotFound < StandardError
    def initialize(tape, name)
      super "The hooklet '#{name}' in tape '#{tape.name}' could not be found."
    end
  end

  class InvalidHook < StandardError
    def initialize(name)
      super "'#{name}' is not a valid Git hook."
    end
  end

  class TapeNotFound < StandardError
    def initialize(name)
      super "The tape '#{name}' could not be found."
    end
  end

end
