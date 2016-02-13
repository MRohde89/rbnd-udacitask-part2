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
      value = " ⇧"
    elsif priority == "medium"
      value = " ⇨"
    elsif priority == "low"
      value = " ⇩"
    elsif priority == nil
      value = ""
    else return raise UdaciListErrors::InvalidPriorityValue, "#{priority} is not a valid priority type!"
    end
    return value
  end
end
