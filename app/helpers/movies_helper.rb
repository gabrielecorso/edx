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
        haml_concat link_to name, "/movies?id=" + sortBy, :id => id, :class => @hilite
      end
    end
  end

  #def button (rating)
  #  if (params[:rating] != nil) and (params[:rating].has_key?(rating)) then
  #    haml_concat ("= check_box_tag \"ratings\[1\]\" ")
  #  else    
  #    haml_concat ("= check_box_tag \"ratings\[\{1\}\]\" ")
  #  end
  #end


  def yellow_filter?(sortBy,name,id,parametros)
    #ratings[G]=1&
    string_parametros = ""
    if parametros == nil then
       string_parametros = ""
    else
       #string_parametros = print parametros 
       # parametros es un hash
       parametros.each_key  do |p|
         string_parametros =  string_parametros + "&" + "ratings[" + p + "]=1"
       end
    end
    if params[:id] == sortBy then 
      haml_tag :th, id: sortBy, class: 'hilite' do
        haml_concat link_to name, "/movies?id=" + sortBy + string_parametros, :id => id, :class => @hilite
      end
    else
      haml_tag :th, id: sortBy,  do
        haml_concat link_to name, "/movies?id=" + sortBy + string_parametros, :id => id, :class => @hilite
      end
    end
  end

  




end

