(function() {
	var count = window.services.length;

	var current = [];
	var errors = [];

	function computeIcon(service) {
		if(isIn(current, service)) {
			return 'icon-check';
		} else if(isIn(errors, service)) {
			return 'icon-attention';
		} else {
			return 'icon-arrows-ccw';
		}
	}

	function isIn(array, service) {
		var found = false;
		Array.prototype.forEach.call(array, function(one) {
			if(one.url == service.url) { found = true; };
		});
		return found;
	}

	function updateBar() {
		var percentage = count == 0 ? 100 : (current.length / count) * 100;
		var el = document.querySelector('.progress-bar');
		el.style.width = percentage + '%';
		el.setAttribute('aria-valuenow', percentage);

		if(current.length == count) {
			set('#waiting', 'hide'); set('#logout-success', ''); set('#finish-message', '');
		} else if(current.length + errors.length == count) {
			set('#waiting', 'hide'); set('#logout-error', ''); set('#finish-message', '');
		}

		var html = "";
		Array.prototype.forEach.call(window.services, function(service) {
			icon = computeIcon(service);
			html += '<p><i class="' + icon + '">&nbsp;</i>' + service.name + '</p>';
		});
		document.querySelector('#service-list').innerHTML = html;
	}

	function set(selector, className) {
		document.querySelector(selector).className = className;
	}

	updateBar();

	var timeoutID=0;
	function startLogout(idx) {
		var logout_iframe=document.querySelector('#logout_iframe');
		var new_element = logout_iframe.cloneNode(true);
		logout_iframe.parentNode.replaceChild(new_element, logout_iframe);
		new_element.addEventListener('load',function(){endLogoutItem(idx,false)});
		timeoutID=setTimeout(function(){endLogoutItem(idx,true)},'15000');
		new_element.src=services[idx].url;
	}

	function endLogoutItem(idx,timedOut){
		var logout_iframe=document.querySelector('#logout_iframe');
		if(timedOut) {
			errors.push(services[idx]);
		} else {
			clearTimeout(timeoutID);
			current.push(services[idx]);
		}
		idx++;
		if(idx<count){
			startLogout(idx);
		}
		updateBar();
	}

	startLogout(0);
})();