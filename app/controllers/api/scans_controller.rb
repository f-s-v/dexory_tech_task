class Api::ScansController < ApplicationController
  protect_from_forgery with: :null_session

  # POST /api/scans
  # POST /api/scans.json
  def create
    @scan = Scan.create_from_import(scan_params)

    if @scan.save
      render json: @scan
    else
      render json: @scan.errors, status: :unprocessable_entity
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def scan_params
      params.require(:_json).map do |param|
        param.permit(:name, :scanned, :occupied, detected_barcodes: []).to_h
      end
    end
end
