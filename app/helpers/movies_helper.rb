module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  def yellow?(sortBy,name,id)
    if params[:id] == sortBy then 
      haml_tag :th, id: sortBy, class: 'hilite' do
        haml_concat link_to name, "/movies?id=" + sortBy, :id => id, :class => @hilite
      end
    else
      haml_tag :th, id: sortBy,  do
        haml_concat link_to name, "/movies?id=" + sortBy, :id => sortBy, :class => @hilite
      end
    end
  end

end

