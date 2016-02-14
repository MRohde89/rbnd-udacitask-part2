class LinkItem
  include Listable
  attr_reader :description, :site_name

  def initialize(url, options={})
    @description = url
    @site_name = options[:site_name]
  end
  # def details
  #   format_description(@discription) + "site name: " + format_name(@site_name)
  # end
  def details
    table_data = [
      { :"1. item_type" => "Link",
        :"2. description" => @description,
        :"3. site_name" => format_name(@site_name),
      }
    ]
    Formatador.display_table(table_data)
  end
end
