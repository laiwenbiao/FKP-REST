var libs = require('libs/libs');
var api = require('libs/api')

SA.setter("_WEIXIN",{})

function getwx(){
    var url = libs.urlparse(location.href)
    if(url.params.code && url.params.state){
        cd = url.params.code;
        st = url.params.state;
        // api.wx()
        api.wx('userinfo', {code: cd, state: st})
        .then(function(data){
            console.log(data);
        })
    }
    return true;
}

module.exports = getwx()