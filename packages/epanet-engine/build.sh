#!/bin/bash

set -e


echo "============================================="
echo "Compiling wasm bindings"
echo "============================================="
(

  # Compile C/C++ code
  emcc -O0 -o ./index.js /opt/epanet/build/lib/libepanet2.a \
    -I /opt/epanet/src/include \
    test.c \
    src/epanet_wrapper.cpp \
    --bind \
    -s EXPORTED_FUNCTIONS="['_EN_geterror','_EN_getversion']" \
    -s NO_EXIT_RUNTIME="1" \
	    -s DEAD_FUNCTIONS="[]" \
	    -s FORCE_FILESYSTEM="1" \
	    -s INLINING_LIMIT="1" \
		-s ALLOW_MEMORY_GROWTH="1" \
    -s ERROR_ON_UNDEFINED_SYMBOLS=0 \
	    -s EXPORTED_RUNTIME_METHODS='["ccall", "getValue", "UTF8ToString", "intArrayToString","FS"]' \
		-s WASM=0 \
		--llvm-lto 3 \
    -s MODULARIZE=1 \
		--memory-init-file 0 \
    --closure 0


  # Create output folder
  mkdir -p dist
  # Move artifacts
  mv index.js dist

)
echo "============================================="
echo "Compiling wasm bindings done"
echo "============================================="