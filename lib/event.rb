class EventItem
  include Listable
  attr_reader :description, :start_date, :end_date

  def initialize(description, options={})
    @description = description
    @start_date = Chronic.parse(options[:start_date]) if options[:start_date]
    @end_date = Chronic.parse(options[:end_date]) if options[:end_date]
  end
  def details
    table_data = [
      { :"1. item_type" => "event",
        :"2. description" => @description,
        :"3. event_dates" => format_date(@start_date,@end_date, "list")
      }
    ]
    Formatador.display_table(table_data)
  end
end
