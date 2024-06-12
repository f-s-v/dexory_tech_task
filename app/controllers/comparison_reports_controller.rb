class ComparisonReportsController < ApplicationController
  before_action :set_scan
  before_action :set_comparison_report, only: %i[ show ]

  # GET /scan/1/comparison_reports/1
  def show
    @report_items = @comparison_report.items_with_scans
  end

  # GET /scan/1/comparison_reports/new
  def new
    @comparison_report = @scan.comparison_reports.new
  end

  # POST /scan/1/comparison_reports
  def create
    csv_file = comparison_report_params[:report_csv]
    raise ActionController::BadRequest.new unless csv_file.present?

    @comparison_report = @scan.create_report_from_csv(csv_file.read)

    redirect_to scan_comparison_report_url(@scan, @comparison_report), notice: "Comparison report was successfully created."
  end

  private
    def set_scan
      @scan = Scan.find_by_id!(params[:scan_id])
    end

    def set_comparison_report
      @comparison_report = @scan.comparison_reports.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comparison_report_params
      params.require(:comparison_report).permit(:report_csv)
    end
end
