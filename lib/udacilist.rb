class UdaciList
  include UdaciListErrors
  attr_reader :title, :items

  def initialize(options={})
    nil == options[:title] ? @title = "Untitled List" : @title = options[:title]
    @items = []
  end
  def add(type, description, options={})
    # adds items based on the type
    type = type.downcase
    if type == "todo"
      if valid_priority?(options[:priority])
        # if a valid priority is provided, the item will be added. Else it will raise an error
        @items.push TodoItem.new(description, options)
      else
        raise UdaciListErrors::InvalidPriorityValue, "#{options[:priority].to_s} is not a supported priority class"
      end
    elsif type == "event"
      @items.push EventItem.new(description, options)
    elsif type == "link"
      @items.push LinkItem.new(description, options)
    elsif type == "image"
      @items.push ImageItem.new(description, options)
    else
      # if a given type does not match a valid type, it will throw an error
      raise UdaciListErrors::InvalidItemType, "#{type} is not supported in the list!"
    end
  end
  def delete(index)
    # delete at index, if there is no item at the given index it will throw an error
    if (index - 1) < @items.length
      @items.delete_at(index - 1)
    else
      raise UdaciListErrors::IndexExceedsListSize, "#{index} is exceeding list length. List is #{@items.length} items long!"
    end
  end
  def all(title = @title, classes = [ EventItem, LinkItem, TodoItem, ImageItem] )
    # used for printing of the list
    # the standard list consist out of all possible types/classes. This can be changed with the filter method
    warning_counter = 0 # will be set to 0 at the beginning. Used if there is no item which match the given type
    puts "-" * title.length
    # artii is used to make some nice headers
    ascii = Artii::Base.new
    puts ascii.asciify(title.upcase) # title will be changed to filtered list, if there are filter condition for the list
    puts "-" * title.length
    # loop trough items and call details function of every item, if the item is provided in the classes array.
    @items.each_with_index do |item, position|
      puts "#{position + 1})" if classes.include? item.class
      puts "#{item.details}"  if classes.include? item.class
      warning_counter = 1 if classes.include? item.class
    end
    # if there is not a single item of the given type in the list, a warning will be shown
    (warn "No Items available in chosen class") if warning_counter == 0
  end
  def valid_priority?(priority)
    # check if the provided priority is a valid priority
    return (['low','medium','high',''].include? priority.to_s)
  end
  def filter(*type)
    # filter can take multiple choices
    # choosen class is an array which will be appended with a chosen Item class
    chosen_class = []
    chosen_class << EventItem  if type.include? 'event'
    chosen_class << TodoItem   if type.include? 'todo'
    chosen_class << LinkItem   if type.include? 'link'
    chosen_class << ImageItem  if type.include? 'image'
    title = "#{type.join(" and ")} List"
    self.all(title, chosen_class) # call all with given arguments
  end
end
