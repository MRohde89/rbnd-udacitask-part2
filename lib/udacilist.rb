class UdaciList
  include UdaciListErrors
  attr_reader :title, :items

  def initialize(options={})
    nil == options[:title] ? @title = "Untitled List" : @title = options[:title]
    @items = []
  end
  def add(type, description, options={})
    type = type.downcase
    if type == "todo"
      if valid_priority?(options[:priority])
        @items.push TodoItem.new(description, options)
      else
        raise UdaciListErrors::InvalidPriorityValue, "#{options[:priority].to_s} is not a supported priority class"
      end
      #@items.push TodoItem.new(description, options)
    elsif type == "event"
      @items.push EventItem.new(description, options)
    elsif type == "link"
      @items.push LinkItem.new(description, options)
    else
      raise UdaciListErrors::InvalidItemType, "#{type} is not supported in the list!"
    end
  end
  def delete(index)
    if (index - 1) < @items.length
      @items.delete_at(index - 1)
    else
      raise UdaciListErrors::IndexExceedsListSize, "#{index} is exceeding list length. List is #{@items.length} items long!"
    end
  end
  def all
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end
  def valid_priority?(priority)
    return (['low','medium','high',''].include? priority.to_s)
  end
end
