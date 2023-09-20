function launch_access_demo()
{
    let param = {
        cmdType: 'rundemo'
    }
    make_post_request('rundemo.cgi', JSON.stringify(param));
}

function make_post_request(url, params)
{
    var http = new XMLHttpRequest();
    http.open('POST', url, true);

    //Send the proper header information along with the request
    http.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    http.onreadystatechange = function() {//Call a function when the state changes.
        if(http.status != 200) {
            alert("No response");
        }
    }    
    http.send(params);
}