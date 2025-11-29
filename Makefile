.PHONY: generate deps

# Установка плагинов (запускать один раз)
deps:
	go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
	go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
	# Если нужен питон
	pip install grpcio-tools

# Генерация Go и Python кода
generate:
	@echo "Generating Go code..."
	mkdir -p gen/go
	protoc -I proto \
		--go_out=gen/go --go_opt=paths=source_relative \
		--go-grpc_out=gen/go --go-grpc_opt=paths=source_relative \
		proto/*/*.proto
	
	@echo "Updating Go deps..."
	go mod tidy
	@echo "Done."