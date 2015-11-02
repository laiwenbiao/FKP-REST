var libs = require('./libs')

function router(name){
    if(typeof name!=='string') return;
    var url = libs.urlparse(location.href);

    if(name.indexOf('/')===0 || name.indexOf('http')===0){
        window.location.href = name
        return
    }
    SA.setter('_HISTORY', url);
    historyStat({uri: url}, null, '#'+name)

    var tmp = SA.getter(name)
    if(tmp){
        console.log(name);
        // window.location.hash = name;
        SA.setter(name,{})
    }
}

router.goback = function(){
    var history = SA.getter('_HISTORY').data;
    if(history.hash){
        router(history.hash)
    }else{
        window.location.href = history.source
    }
}

//html5
if(window.history.pushState){
    libs.addEvent(window, 'popstate', function(e){
        var val = e.state;
        console.log(val);
        if(val && val.uri && val.uri.hash){
            console.log(val.uri.hash);
            console.log(SA.getter(val.uri.hash));
            router(val.uri.hash);
        }
    })
}

function historyStat(args, title, uri){
    window.history.pushState(args, title, uri)
}

var route = function(name, handle){
    if(typeof SA!=='object'){
        console.log("don't set global SA variable ");
        return;
    }

    if(libs.getObjType(name)==='Object'){
        var keys = Object.keys(name);
        keys.map(function(item, i){
            SA.setter(item, name[item])
        })
    }

    if(typeof name === 'string'){
        if(typeof handle === 'function')
            SA.setter(name, handle)
    }
}

module.exports = {
    router: router,
    route: route
}

/*
* 每一条路由都必须匹配一个方法
* init route
* 'abc'  name: {string}
* abc   value: {function}
*/
// route({
//     'abc': abc,
//     'bcd': bcd
// });
