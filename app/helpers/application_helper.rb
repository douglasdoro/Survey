module ApplicationHelper
  def link_to_remove_fields(name, f)
    f.input(:_destroy, :as => :hidden) + link_to_function(name, "remove_fields(this)", :class => "remove_field")
  end
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, raw("add_fields(this, '#{association}', '#{escape_javascript(fields)}')"), :class => 'add_field')
  end
  
  def show_survey(survey)
    if current_user
			survey.published? or survey.user_id.eql? current_user.id
		else
			survey.published?
		end
  end
  
  def title(page_title)
    content_for :title do
    	page_title
    end
  end  
end
