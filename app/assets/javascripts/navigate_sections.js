$(document).ready(function() {
	var sections = $('.section');

	var hide_all = function() {
		sections.hide();
	}

	var show_all = function() {
		sections.show();
	}

	var show_first = function() {
		sections.each(function(index, item) { 
			if (index == 0) { 
				$(item).show(); 
			} 
		});
	}

	var show_section = function(section) {
		hide_all();
		var item = $('.' + section);
		item.show();
		$('.section-name').text(item.find('h2').text());
	}

	$('.section-links li a').click(function() {
		show_section($(this).data("section"));
		return false;
	});

	$('.show-all-sections').click(function() {
		show_all();
		return false;
	});
});