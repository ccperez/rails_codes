if (history && history.pushState) {
  $(function() {
    // pagination links
	  $("#post .pagination a").live("click", function () {
			  $.getScript(this.href);
			  history.pushState(null, document.title, this.href);
			  return false;
	  });

	  $("#posts_search input").keyup(function () {
			  var action = $('#posts_search').attr('action');
			  var formData = $('#posts_search').serialize();
			  $.get(action, formData, null, 'script');
			  history.replaceState(null, document.title, action + "?" + formData);
			  return false;
	  });

    // Other functions omitted.
	  $(window).bind("popstate", function () {
		  $.getScript(location.href);
	  });
  });
}

$(function() {
  if ($("#comments").length > 0) {
    setTimeout(updateComments, 10000);
  }

  $('a[href$="/delete"]').each(function(){
    this.href = this.href.replace(/\/delete$/, "");
    $(this).attr("data-method","delete");
    $(this).attr("data-confirm","Are you sure?");
  });
});

function updateComments () {
  var post_id = $("#post").attr("data-id");
  if ($(".comment").length > 0) {
    var after = $(".comment:last-child").attr("data-time");
  } else {
    var after = "0";
  }
  $.getScript("/comments.js?post_id=" + post_id + "&after=" + after)
  setTimeout(updateComments, 10000);
}

