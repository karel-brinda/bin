CXX      ?= g++
CXXFLAGS  = -std=c++11 -Wall -Wextra -Wno-missing-field-initializers -g -O2
LIBS      = -lm -lz -lpthread

PREFIX    = $(DESTDIR)/usr/local
BINDIR    = $(PREFIX)/bin

ofiles    = src/main.cpp.o
hfiles    = $(wildcard src/*.h)

.PHONY: all clean install

all: _NAME_

install: _NAME_
	install  _NAME_ $(BINDIR)/_NAME_
	install  $(MANPAGE) $(MANDIR)/$(MANPAGE)

_NAME_: $(ofiles)
	$(CXX) $(CXXFLAGS) $(DFLAGS) $(ofiles) -o $@ -L. $(LIBS) $(HTSLIB)

src/%.cpp.o: src/%.cpp $(hfiles)
	$(CXX) $(CXXFLAGS) $(DFLAGS) -c $< -o $@

clean:
	rm -f src/*.o
	rm -f _NAME_

