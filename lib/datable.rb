# Server side datatable wrapper
class Datable
  # delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(klass, fields, columns, params, &mapper)
    @klass = klass
    @fields = fields
    @columns = columns
    @params = params
    @mapper = mapper
  end

  def as_json(options = {})
    {
      sEcho: @params[:sEcho].to_i,
      iTotalRecords: @klass.count,
      iTotalDisplayRecords: items.total_count,
      aaData: data
    }
  end

  include ActionView::Helpers

  private

  # Mapping of each item of the data
  #
  # do |product|
  #   [
  #     link_to(product.name, product),
  #     h(product.price) + " Kč",
  #     h(product.category_name),
  #     edit_product_link(product) + " " +
  #     delete_product_link(product)
  #   ]
  # end
  #
  def data
    items.map(&@mapper)
  end

  def items
    @items ||= fetch_items
  end

  # Fetch the items from the database
  def fetch_items
    items = @klass.order("#{sort_column} #{sort_direction}")
    items = items.page(page).per(per_page)
    if @params[:sSearch].present?
      # TODO "name like :search OR category_name like :search"
      query = @fields.map { |field| "#{field} like :search" }.join(" OR ")
      items = items.where(query, search: "%#{@params[:sSearch]}%")
    end
    return items
  end

  def page
    @params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    @params[:iDisplayLength].to_i > 0 ? @params[:iDisplayLength].to_i : 10
  end

  def sort_column
    # columns = %w[name price category_name]
    columns = @columns
    columns[@params[:iSortCol_0].to_i]
  end

  def sort_direction
    @params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end

end
