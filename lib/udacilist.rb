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
  def all(title = @title, classes = [ EventItem, LinkItem, TodoItem] )
    puts "-" * title.length
    ascii = Artii::Base.new
    puts ascii.asciify(title)
    puts "-" * title.length
    @items.each_with_index do |item, position|
      #puts item.class if classes.include? item.class
      puts "#{position + 1})" if classes.include? item.class
      puts "#{item.details}"  if classes.include? item.class
    end
  end
  def valid_priority?(priority)
    return (['low','medium','high',''].include? priority.to_s)
  end
  def filter(type)
    chosen_class = [EventItem]  if type == 'event'
    chosen_class = [TodoItem]   if type == 'todo'
    chosen_class = [LinkItem]   if type == 'link'
    title = "#{type.capitalize}-List"
    self.all(title, chosen_class)
  end
end
