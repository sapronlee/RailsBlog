#encoding : utf-8
module Admin::ApplicationHelper
	
	def log_tags(objects, opts = {})
		html = ''
		options = {}
		options[:header_tag] ||= true
		options.update(opts)

		html << content_tag(:li, t("helpers.links.log"), :class => "nav-header") if options[:header_tag]
		
		objects.each do |obj|	
			html << content_tag(:li, log_tag(obj, options))
		end

		content_tag(:ul, html.html_safe, :class => "nav nav-list logs")
	end

	def log_tag(object, opts = {})
		options = {}
		options[:date_tag] ||= true
		options[:model_tag] ||= true
		options[:truncate] ||= false
		options[:popover] ||= true
		options.update(opts)

		action_html = case object.action
		when "create"
			content_tag(:span, t("helpers.logs.create"), :class => "label label-success action-tag")
		when "update"
			content_tag(:span, t("helpers.logs.update"), :class => "label label-info action-tag")
		when "destroy"
			content_tag(:span, t("helpers.logs.destroy"), :class => "label label-important action-tag")
		else
			content_tag(:span, t("helpers.logs.unknown"), :class => "label action-tag")
		end

		model_html = content_tag(:span, t("activerecord.models.#{object.recordable_type.downcase!}"), 
														 :class => "label label-#{object.recordable_type} model-tag") if options[:model_tag]

		
		data_content_html = "<h3 class=\"popover-message\">#{object.message}</h3><span class=\"label\">#{l(object.created_at, :format => :long)}</span>" if options[:popover]

		message_html = content_tag(:span, options[:truncate] ? object.message.truncate(options[:truncate]) : object.message,
															 :class => "message-tag", 
															 :rel => options[:popover] ? :popover : nil,
															 "data-content" => options[:popover] ? data_content_html : nil,
															 :title => options[:popover] ? t("helpers.logs.#{object.action}") : nil)

		date_html = content_tag(:span, "#{time_ago_in_words(object.created_at)}", 
														:class => "date-tag") if options[:date_tag]

		content_tag(:div, raw("#{model_html}#{action_html}#{message_html}#{date_html}"), :class => :log)

	end
end
