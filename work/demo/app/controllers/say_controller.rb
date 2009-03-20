class SayController < ApplicationController

  def hello
    @time = Time.now
  end

  def goodbye
  end

  def looping
  end

  def contents
    @files = Dir.glob('*' )
  end

end
