
function generateUUID() {
    var d = new Date().getTime();
    var uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
        var r = (d + Math.random()*16)%16 | 0;
        d = Math.floor(d/16);
        return (c=='x' ? r : (r&0x3|0x8)).toString(16);
    });
    return uuid;
};

function supports_html5_storage() {
  try {
    return 'sessionStorage' in window && window['sessionStorage'] !== null;
  } catch (e) {
    return false;
  }
}


function sessionId() {

    if ( !supports_html5_storage () ) 
        return 0;

    var id=window.sessionStorage.getItem("orSessionGuid");

    if (!id)
        id = generateUUID();

    window.sessionStorage.setItem("orSessionGuid", id);

    return id;
}

function windowId() {

    if ( !supports_html5_storage () ) 
        return 0;

    var id = window.localStorage.getItem("orWindowGuid");

    if (!id)
        id = -1;

    id = 1 + parseInt(id);

    window.localStorage.setItem("orWindowGuid", id);

    return id;
}
