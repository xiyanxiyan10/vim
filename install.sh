curPath=$(pwd)
echo $curPath 
mkdir -p $curPath/src
export GOPATH=$curPath
export GO111MODULE=on
go env -w GOPROXY=https://goproxy.io,direct
go get -v github.com/nsf/gocode
go get -v golang.org/x/tools/cmd/goimports
go get -v github.com/rogpeppe/godef
go build && go install 
sudo cp bin/gocode /usr/local/bin
sudo cp bin/goimports /usr/local/bin
sudo cp bin/godef /usr/local/bin

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

sudo cnpm install -g eslint-plugin-react
sudo cnpm install -g eslint
sudo cnpm install -g prettier
sudo cnpm install -g eslint-plugin-prettier
sudo cnpm install -g eslint-config-prettier
sudo cnpm install -g js-beautify
sudo apt install ctags
sudo apt install astyle
# open vim and BundleInstall
