install:
	brew install sile
	luarocks --lua-version 5.1 --tree lua_modules install resilient.sile
build:
	sile -u inputters.silm ddd-reference.silm
