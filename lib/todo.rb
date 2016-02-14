class TodoItem
  include Listable
  attr_reader :description, :due, :priority

  def initialize(description, options={})
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    @priority = options[:priority]
  end
  def details
    # uses formatador to make a table view out of the hash
    table_data = [
      { :"1. item_type" => "ToDo",
        :"2. description" => @description,
        :"3. date" => format_date(@start_date,nil,"due"),
        :"4. priority" => format_priority(@priority)
      }
    ]
    Formatador.display_table(table_data)
  end
end
