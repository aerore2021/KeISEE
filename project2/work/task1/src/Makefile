WHISPER_DIR = /whisper 
BOOST_DIR = /opt/boost_1_83_0

OBJS = decode.cpp Hart.cpp Hart.hpp InstEntry.cpp instforms.cpp instforms.hpp InstId.hpp

build:
	cp $(OBJS) $(WHISPER_DIR)
	make -C $(WHISPER_DIR) BOOST_DIR=$(BOOST_DIR)