(function () {
    function $(query) { return document.querySelector(query); };
    function all(selector, listener) {
        Array.prototype.forEach.call(document.querySelectorAll(selector), function(el) { listener(el); });
    }
    function validate(){
        var action = $('.action'); var form = $('#loginForm');
        if (form['username'].value && form['password'].value) {
            action.removeAttribute('disabled'); action.style.backgroundColor = '#009DE0';
        } else {
            action.setAttribute('disabled', true); action.style.backgroundColor = '#CCC';
        }
    };
    validate();

    all('form input', function(el) { el.addEventListener('change', validate); });

    $('#auth-box').addEventListener('click', function() {
        var modes = $('#auth-modes');
        modes.className = modes.className ? '' : 'show-menu';
    });
    $('.paises').addEventListener('click', function() {
        var modes = $('#country-chooser');
        modes.className = modes.className ? '' : 'show-menu';
    });
    all('[data-toggle-auth-method]', function(el) {
        var type = el.getAttribute('data-toggle-auth-method');
        el.addEventListener('click', function() {
            all('[data-auth-method]', function(el) { el.style.display = 'none'; });
            $('#auth-method').parentNode.className = 'chosen';
            $('#auth-method').innerHTML = el.querySelector('a').innerHTML;
            $('[data-auth-method=' + type + ']').style.display = 'inherit';
        });
    });
    document.onkeydown = function(e) {
        if((e.keyCode || e.which) == 27) { $('#auth-modes').className = ''; }
    };
    document.addEventListener('click', function(event) {
        var current = event.target;
        while(current) {
            if(current.id == 'auth-box') { return; }
            current = current.parentNode;
        }
        $('#auth-modes').className = '';
    });
})();
