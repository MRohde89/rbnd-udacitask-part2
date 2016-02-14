module UdaciListErrors
  class InvalidItemType < StandardError
    # error for invalid item type
  end
  class IndexExceedsListSize < StandardError
    # error if provided index exceeds the list size
  end
  class InvalidPriorityValue < StandardError
    # error if the provided priority is not the valid
  end
end
