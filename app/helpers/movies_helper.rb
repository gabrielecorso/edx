module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  def yellow?(sortBy,name,id)
    haml_tag :th, id: sortBy, class: "#{if params[:id] == sortBy then 'hilite' end}" do
      haml_concat link_to name, {:class => @hilite,:id => sortBy}
    end
  end

end


