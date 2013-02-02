module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  def yellow?(sortBy,name,id)
    if params[:id] == sortBy then 
      haml_tag :th, id: sortBy, class: "#{if params[:id] == sortBy then 'hilite' end}" do
        haml_concat link_to name, :id => sortBy, :class => @hilite
      end
    else
      haml_tag :th, id: sortBy, class: "#{if params[:id] == sortBy then 'hilite' end}" do
        haml_concat link_to name, :id => sortBy, :class => @hilite
      end
    end
  end

end

