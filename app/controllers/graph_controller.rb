class GraphController < ApplicationController
  def index
  end

  def data
  end

  def stacked

    @find_tags = ["household", "food", "drinks", "transport"]
    @current_day  = (DateTime.now - 1.month).beginning_of_month
    @output = "date,household,food,drinks,transport"

    for week_no in 0..4

      @week_tags = []
      for i in 0..7
        @week_tags << (@current_day + (week_no * 7) + i).strftime('%Y-%m-%d')
      end
      @eentries = Eentry.in(tags: @week_tags).order_by(:created.asc)

      @current_line = Hash.new
      @find_tags.each do |tag|
        @current_line[tag] = 0
      end

      @eentries.each do |entry|
        tags = entry.tags

        tags.each do |tag|
          if @find_tags.include? tag
            @current_line[tag] += entry.amount.to_f
          end
        end

      end

      @output += "\n" + (@current_day + (week_no * 7)).strftime('%Y-%m-%d') + "," + ('%.2f' % @current_line["household"]).to_s + "," + ('%.2f' % @current_line["food"]).to_s + "," + ('%.2f' % @current_line["drinks"]).to_s + "," + ('%.2f' % @current_line["transport"]).to_s
    end

    respond_to do |format|
      format.html { render :layout => false }
    end
  end

end