/'
   keyboard.bas
   
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

#include "keyboard.bi"
#include "main.bi"
#include "io.bi"
#include "display.bi"

sub keyboard_read()

	dim key as string
	dim i as integer
	
	const KEY_LEFT  = chr(255) & chr(75)	
	const KEY_RIGHT = chr(255) & chr(77)
	const KEY_UP    = chr(255) & chr(72)
	const KEY_DOWN  = chr(255) & chr(80)
	const KEY_DEL = CHR$(255) + "S"
    const KEY_ESC = CHR$(27)
    const KEY_BS = CHR$(8)
    const KEY_TAB = CHR$(9)
    const KEY_PGUP = CHR$(255) + "I"
    const KEY_PGDOWN = CHR$(255) + "Q"
    const KEY_HOME = CHR$(255) + "G"
    const KEY_END = CHR$(255) + "O"
    const KEY_INSERT = CHR$(255) + "R"
    const KEY_ENTER = CHR$(13)
    const KEY_F1 = CHR$(255) + CHR$(59)
    const KEY_F2 = CHR$(255) + CHR$(60)
    const KEY_F3 = CHR$(255) + CHR$(61)
    const KEY_F4 = CHR$(255) + CHR$(62)
    const KEY_F5 = CHR$(255) + CHR$(63)
    const KEY_F6 = CHR$(255) + CHR$(64)
    const KEY_F7 = CHR$(255) + CHR$(65)
    const KEY_F8 = CHR$(255) + CHR$(66)
    const KEY_F9 = CHR$(255) + CHR$(67)
    const KEY_F10 = CHR$(255) + CHR$(68)
    const KEY_F11 = CHR$(255) + CHR$(133)
    const KEY_F12 = CHR$(255) + CHR$(134)
    const KEY_CTRLC = CHR$(3)
    const KEY_CTRLS = CHR$(19)
    const KEY_CTRLT = CHR$(20)
    const KEY_CTRLQ = CHR$(17)
    const KEY_CTRLW = CHR$(23)

	do
		key = inkey()
	/'
		if key <> "" then
			for i = 1 to len(key)
				print asc(mid(key, i, 1)); " ";
			next i
		end if 
	'/
		select case key
			case KEY_F5
				cls
				print io_get_buffer_offset(current_buffer)
				sleep
				display_redraw
			case KEY_ESC
				exit_editor
			case KEY_LEFT
				io_dec_buffer_offset current_buffer
				display_redraw
			case KEY_RIGHT
				io_inc_buffer_offset current_buffer
				display_redraw
			case KEY_UP
				io_set_buffer_offset current_buffer, io_get_buffer_offset(current_buffer) - 16
				display_redraw
			case KEY_DOWN
				io_set_buffer_offset current_buffer, io_get_buffer_offset(current_buffer) + 16			
				display_redraw
		end select
	
	loop 
	
end sub
