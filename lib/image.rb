class ImageItem
  include Listable
  attr_reader :description, :url

  def initialize(description, options={})
    @description = description
    @url = options[:url]
  end
  def details
    # uses formatador to make a table view out of the hash
    table_data = [
      { :"1. item_type" => "Image",
        :"2. description" => @description
      }
    ]
    Formatador.display_table(table_data)
    # uses Catpix to print the image to the command line
    Catpix::print_image @url.to_s
  end
end
