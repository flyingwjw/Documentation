# git clone https://github.com/golang/tools.git tools
# 需要把tools目录下的所有文件拷贝到%GOPATH%\src\golang.org\x\tools下，如果没有自行创建

# 
# 'gocode': 'github.com/mdempsky/gocode',
# 'gocode-gomod': 'github.com/stamblerre/gocode',
# 'gopkgs': 'github.com/uudashr/gopkgs/cmd/gopkgs',
# 'go-outline': 'github.com/ramya-rao-a/go-outline',
# 'go-symbols': 'github.com/acroca/go-symbols',
# 'guru': 'golang.org/x/tools/cmd/guru',
# 'gorename': 'golang.org/x/tools/cmd/gorename',
# 'gomodifytags': 'github.com/fatih/gomodifytags',
# 'goplay': 'github.com/haya14busa/goplay/cmd/goplay',
# 'impl': 'github.com/josharian/impl',
# 'gotype-live': 'github.com/tylerb/gotype-live',
# 'godef': 'github.com/rogpeppe/godef',
# 'godef-gomod': 'github.com/ianthehat/godef',
# 'gogetdoc': 'github.com/zmb3/gogetdoc',
# 'goimports': 'golang.org/x/tools/cmd/goimports',
# 'goreturns': 'github.com/sqs/goreturns',
# 'goformat': 'winterdrache.de/goformat/goformat',
# 'golint': 'golang.org/x/lint/golint',
# 'gotests': 'github.com/cweill/gotests/...',
# 'gometalinter': 'github.com/alecthomas/gometalinter',
# 'megacheck': 'honnef.co/go/tools/...',
# 'golangci-lint': 'github.com/golangci/golangci-lint/cmd/golangci-lint',
# 'revive': 'github.com/mgechev/revive',
# 'go-langserver': 'github.com/sourcegraph/go-langserver',
# 'dlv': 'github.com/derekparker/delve/cmd/dlv',
# 'fillstruct': 'github.com/davidrjenni/reftools/cmd/fillstruct'

# Get Source
get()
{
	# gocode
	go get -u -v github.com/mdempsky/gocode
	# gopkgs
	go get -u -v github.com/uudashr/gopkgs/cmd/gopkgs
	# go-outline
	go get -u -v github.com/ramya-rao-a/go-outline
	# go-symbols
	go get -u -v github.com/acroca/go-symbols
	# guru
	# go get -u -v golang.org/x/tools/cmd/guru
	# gorename
	# go get -u -v golang.org/x/tools/cmd/gorename
	# dlv
	go get -u -v github.com/derekparker/delve/cmd/dlv
	# gocode-gomod
	go get -u -v github.com/stamblerre/gocode
	# godef
	go get -u -v github.com/rogpeppe/godef
	# godef-gomod
	go get -u -v github.com/ianthehat/godef
	# godoc
	# goreturns
	go get -u -v github.com/sqs/goreturns
	# golint
	# go get -u -v golang.org/x/lint/golint
	# gotests
	go get -u -v github.com/cweill/gotests/...
	# gomodifytags
	go get -u -v github.com/fatih/gomodifytags
	# impl
	go get -u -v github.com/josharian/impl
	# fillstruct
	go get -u -v github.com/davidrjenni/reftools/cmd/fillstruct
	# goplay
	go get -u -v github.com/haya14busa/goplay/cmd/goplay
}

install()
{
	# gocode
	go install github.com/mdempsky/gocode
	# gopkgs
	go install github.com/uudashr/gopkgs/cmd/gopkgs
	# go-outline
	go install github.com/ramya-rao-a/go-outline
	# go-symbols
	go install github.com/acroca/go-symbols
	# guru
	go install golang.org/x/tools/cmd/guru
	# gorename
	go install golang.org/x/tools/cmd/gorename
	# dlv
	go install github.com/derekparker/delve/cmd/dlv
	# gocode-gomod
	go install github.com/stamblerre/gocode
	# godef
	go install github.com/rogpeppe/godef
	# godef-gomod
	go install github.com/ianthehat/godef
	# godoc
	# goreturns
	go install github.com/sqs/goreturns
	# golint
	# go install golang.org/x/lint/golint
	# gotests
	go install github.com/cweill/gotests/...
	# gomodifytags
	go install github.com/fatih/gomodifytags
	# impl
	go install github.com/josharian/impl
	# fillstruct
	go install github.com/davidrjenni/reftools/cmd/fillstruct
	# goplay
	go install github.com/haya14busa/goplay/cmd/goplay
}

get
install