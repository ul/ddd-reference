install:
	brew install sile
	luarocks --lua-version 5.1 --tree lua_modules install resilient.sile 3.4.0
build:
	sile -u inputters.silm ddd-reference.silm
