build:
	./k-framework/tools/kcompile.sh kruby

test: build
	maude kruby-test.maude
