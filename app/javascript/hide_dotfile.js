function _toggle_text() {
    let hide_button = document.getElementById('hide-button');
    if (hide_button.textContent == 'Show') {
        hide_button.textContent = 'Hide';
    } else {
        hide_button.textContent = 'Show';
    }
}

document.getElementById('hide-button').addEventListener('click', function() {
    let target = document.getElementById('hide-target');
    if (target.style.display === 'none') {
        target.style.display = 'block';
    } else {
        target.style.display = 'none';
    }
    _toggle_text();
});
