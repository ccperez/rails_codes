// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

	$(function () {
		// Sorting and pagination links.
		$("#search_item th a, #search_item .pagination a").live("click", function () {  
			$.getScript(this.href);
			return false;  
		});

		// Search form.  
		$("#search_form input").submit(function () {  
				var action = $('#search_form').attr('action');  
				var formData = $('#search_form').serialize();  
				$.get(action, formData, null, 'script');  
				return false;   
		});

	})

