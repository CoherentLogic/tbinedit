#  Makefile
#  
#  Copyright 2016 John P. Willis <jpw@coherent-logic.com>
#  
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#  
#  

FBCFLAGS = -g -exx
OBJS = display.o keyboard.o io.o lexer.o main.o

all: be

be: $(OBJS)
	fbc $(FBCFLAGS) -x be $(OBJS)
	
main.o: main.bas
	fbc $(FBCFLAGS) -m main -o main.o -c main.bas
	
display.o: display.bas
	fbc $(FBCFLAGS) -c display.bas

keyboard.o: keyboard.bas
	fbc $(FBCFLAGS) -c keyboard.bas

io.o: io.bas
	fbc $(FBCFLAGS) -c io.bas
	
lexer.o: lexer.bas
	fbc $(FBCFLAGS) -c lexer.bas
	
clean:
	rm -f $(OBJS)
	rm -f be
	
