function refreshParent() {
    window.opener.location.href = window.opener.location.href;

    if (window.opener.progressWindow) {
        window.opener.progressWindow.close()
    }
    window.close();
}