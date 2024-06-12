class ScansController < ApplicationController
  def index
    @scans = Scan.all
  end
end
