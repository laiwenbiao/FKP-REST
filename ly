#!/bin/bash

# dev
dev(){
    cd public
    gulp dev

    cd ..
    if [ $1 ]; then
        nodemon -e js,jsx --ignore public/ --harmony index.js dev $1 &
    else
        nodemon -e js,jsx --ignore public/ --harmony index.js dev &
    fi
    sleep 2

    cd public
    if [ $1='test' ]; then
        gulp watch
    else
        if [ $1 ]; then
            gulp watch --port $1
        else
            gulp watch
        fi
    fi
}

bbdev(){
    cd public
    gulp bbdev

    cd ..
    nodemon -e js,jsx --ignore public/ --harmony index.js dev &
    sleep 2

    cd public
    gulp watch
}

pro(){

    cd public
    gulp build

    cd ..
    nodemon -e js,jsx --ignore public/ --harmony index.js &
    sleep 2

    cd public
    gulp watch:pro
}

demo(){
    cd public
    gulp
}

ngdemo(){
    cd public
    gulp ng
}

ngdev(){
    cd public
    gulp ngdev
    cd ..
    nodemon -e js,jsx --ignore public/ --harmony index.js ngdev &
}

bbdemo(){
    cd public
    gulp bb
}

bbdemo(){
    cd public
    gulp bb
}

install2(){
    # read -s -p "请输入sudo密码: " psd
    # echo $psd | sudo npm install nrm -g
    # nrm use cnpm
    # sleep 3
    # echo $psd | sudo npm install gulp -g
    # echo $psd | sudo npm install nodemon -g
    # echo $psd | sudo npm install node-gyp -g

    sudo npm install nrm -g
    nrm use cnpm
    sleep 3
    sudo npm install gulp -g
    sudo npm install nodemon -g
    sudo npm install node-gyp -g
}

install3(){
    npm install nrm -g
    nrm use cnpm
    sleep 3
    npm install gulp -g
    npm install nodemon -g
    npm install node-gyp -g
    npm install

    cd public
    npm install

    cd ..
}

install(){
    install2
    npm install

    cd public
    npm install

    cd ..
}

server(){
	nodemon -e js,jsx --ignore public/ --harmony index dev
}

build(){
    cd public
    gulp build
    pm2 restart all
}

case $1 in
  install)
      install
      ;;
  install2)
      install2
      ;;
  install3)
      install3
      ;;
  server)
      server
      ;;
  dev)
      dev $2
      ;;
  pro)
      pro
      ;;
  demo)
      demo
      ;;
  ngdemo)
      ngdemo
      ;;
  ngdev)
      ngdev
      ;;
  bbdemo)
      bbdemo
      ;;
  build)
      build
      ;;
esac
