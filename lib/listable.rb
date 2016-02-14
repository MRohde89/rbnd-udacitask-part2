module Listable
  def format_description(description)
    "#{description}".ljust(30)
  end
  def format_date(start_date = nil, end_date = nil, type)
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
    site_name ? site_name : ""
  end

  # def details(type,description,options={})
  #   format_description(description)
  #   ("event dates: " + format_date(options[:start_date],options[:end_date], "list")) if type == "list"
  #   ("site name: " + format_name(options[:site_name])) if type == "link"
  #   (format_date(options[:start_date],nil,"due") + format_priority(options[:priority])) if type == "event"
  # end
end
