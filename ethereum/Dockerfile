FROM alpine:latest

EXPOSE 6060
EXPOSE 8545
EXPOSE 30303

RUN \
	set -x -v && \
	apk update && \
	apk add mlocate curl make go && \
	wget -O go.tgz https://golang.org/dl/go1.16.4.linux-amd64.tar.gz && \
	tar -C /usr/local -xzf go.tgz && \
	cd /usr/local/go/src/ && \
	sh make.bash && \
	apk add --no-cache --virtual .build-deps git make alpine-sdk linux-headers && \
	git clone https://github.com/ethereum/go-ethereum.git && \
	cd go-ethereum && \
	make geth && \
	mv ./build/bin/geth /usr/bin/geth && \
	apk del .build-deps && \
	cd .. && \
	rm -rf go-ethereum

CMD ["/usr/bin/geth", "--http","--http.addr", "0.0.0.0", "--http.api", "db,personal,eth,net,web3", "--metrics", "--metrics.expensive", "--metrics.addr", "0.0.0.0"]
