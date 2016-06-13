/'
   main.bas
   
   Copyright 2016 John P. Willis <jpw@coherent-logic.com>
   
   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
   MA 02110-1301, USA.
   
   
'/

#include "main.bi"
#include "io.bi"
#include "lexer.bi"
#include "display.bi"
#include "keyboard.bi"

sub main(args as string)

	dim i as integer
	dim cnt as integer
	dim idx as integer
	
	io_init	
	
	cnt = lex(args)
	
	for i = 0 to cnt - 1
		idx = io_open(get_lexer_entry(i).strval)
	next i
	
	current_buffer = idx
	
	display_init
	display_redraw
	keyboard_read
	
end sub

sub exit_editor()

	io_check_buffers 

	color 7, 0
	cls
	
	end
end sub

main command()
