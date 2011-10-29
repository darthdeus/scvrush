if <%= @saved %>
  $('#category_name').val ''
  new_option = $("<option value='<%= @category.id %>'><%= @category.name %></option>").attr('selected', 'selected')
  $('select#article_category_id').append(new_option).focus()
else
  alert "Category already exists"
  $('#category_name').val('').focus()    



