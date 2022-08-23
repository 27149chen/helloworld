API_PROTO_FILES=$(shell find helloworld -name *.proto)

.PHONY: init
# init env
init:
	go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
	go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
	go install github.com/go-kratos/kratos/cmd/kratos/v2@latest
	go install github.com/go-kratos/kratos/cmd/protoc-gen-go-http/v2@latest
	go install github.com/go-kratos/kratos/cmd/protoc-gen-go-errors/v2@latest
	go install github.com/google/gnostic/cmd/protoc-gen-openapi@latest
	go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2@latest

.PHONY: api
# generate api proto
api:
	protoc --proto_path=./helloworld \
           --proto_path=./third_party \
           --go_out=paths=source_relative:./helloworld \
           --go-errors_out=paths=source_relative:./helloworld \
           --go-http_out=paths=source_relative:./helloworld \
           --go-grpc_out=paths=source_relative:./helloworld \
           --openapi_out==paths=source_relative:. \
           --openapiv2_out ./helloworld \
           --openapiv2_opt logtostderr=true \
           --openapiv2_opt json_names_for_fields=false \
           $(API_PROTO_FILES)