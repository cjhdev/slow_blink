require 'stringio'
 
module Kernel
 
  def capture_stderr

    err = StringIO.new
    $stderr = err

    yield

    return err

    ensure

    $stderr = STDERR
        
  end
 
end
