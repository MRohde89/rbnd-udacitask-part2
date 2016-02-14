module Listable
  def format_description(description)
    "#{description}".ljust(30)
  end
  def format_date(start_date = nil, end_date = nil, type)
    # looks what kind of date is needed based on the type. Starting end_date date is not mandatory
    if type == "due"
      start_date ? (return start_date.strftime("%D")) : (return "No due date")
    elsif type == "list"
      dates = start_date.strftime("%D") if start_date
      dates << " -- " + end_date.strftime("%D") if end_date
      dates = "N/A" if !dates
      return dates
    end
  end
  def format_priority(priority)
    # uses colorize to highlight different priorities. The validation of the priority is made in udacilist.rb
    if priority == "high"
      value = " ⇧ ".colorize(:red)
    elsif priority == "medium"
      value = " ⇨ ".colorize(:yellow)
    elsif priority == "low"
      value = " ⇩ ".colorize(:blue)
    else
      value = ""
    end
    return value
  end
  def format_name(site_name)
    # formats the name of the site
    site_name ? site_name : ""
  end
end
