curPath=$(pwd)
echo $curPath 
mkdir -p $curPath/src
export GOPATH=$curPath
export GO111MODULE=on
go env -w GOPROXY=https://goproxy.io,direct
go get github.com/nsf/gocode
go get golang.org/x/tools/cmd/goimports
go build && go install 
sudo cp bin/gocode /usr/local/bin
sudo cp bin/goimports /usr/local/bin



git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

npm install -g eslint
npm install -g prettier
npm install -g eslint-plugin-prettier
npm install -g eslint-config-prettier
npm install -g js-beautify
sudo apt install ctags
sudo apt install astyle
# open vim and BundleInstall
