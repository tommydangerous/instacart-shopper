class FunnelsController < ApplicationController
  def index
    @funnel = funnel_serializer.serialize

    respond_to do |format|
      format.html { @chart_funnel = formatted_funnel }
      format.json { render json: @funnel }
    end
  end

  private

  def end_date
    end_date = params[:end_date].try(:to_date) || Date.today
  end

  def formatted_funnel
    # generates a formatted version of the funnel for display in d3
    formatted = Hash.new { |h, k| h[k] = [] }

    @funnel.each do |date, state_counts|
      state_counts.each do |state, count|
        formatted[state] << {label: date, value: count}
      end
    end

    formatted.map do |k, v|
      {
        key: k.humanize,
        values: v
      }
    end
  end

  def funnel_serializer
    @funnel_serializer ||= FunnelsSerializer.new(start_date, end_date)
  end

  def start_date
    params[:start_date].try(:to_date) || Date.today
  end
end
