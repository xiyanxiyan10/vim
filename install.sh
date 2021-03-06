curPath=$(pwd)
echo $curPath 

if [ $# -eq 0 ];
then
    echo "please select system, mac or linux"
    exit
fi
# echo "$1"

if [ "$1" = "mac" ];then
echo "mac system"
# install ctgs for mac
brew install ctags-exuberant
# install ack for mac
brew install ack
brew install cscope
fi

if [ "$1" = "linux" ];then
echo "linux system"
sudo apt-get install ctags
sudo apt-get install cscope
sudo apt-get install astyle
fi

mkdir -p $curPath/src
export GOPATH=$curPath
export GO111MODULE=on
go env -w GOPROXY=https://goproxy.io,direct
go mod init $curPath
go get -v github.com/nsf/gocode
go get -v golang.org/x/tools/cmd/goimports
go get -v github.com/rogpeppe/godef
go get -v github.com/jstemmer/gotags
go build && go install 
sudo cp bin/gocode /usr/local/bin
sudo cp bin/goimports /usr/local/bin
# godef only work when GO111MODULE=off
sudo cp bin/godef /usr/local/bin
sudo cp bin/gotags /usr/local/bin

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim


pip install --upgrade autopep8
pip install --upgrade flake8
pip install --upgrade pycscope
pip install --upgrade vim-vint
pip install --upgrade pylint
sudo gem install mdl
sudo cnpm install -g eslint-plugin-react
sudo cnpm install -g eslint
sudo cnpm install -g prettier
sudo cnpm install -g eslint-plugin-prettier
sudo cnpm install -g eslint-config-prettier
sudo cnpm install -g js-beautify



