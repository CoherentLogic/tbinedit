/'
   display.bas
   
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

#include "display.bi"
#include "io.bi"
#include "main.bi"

dim shared con_width as integer
dim shared con_height as integer
dim shared lrow as integer
dim shared bytes_per_page as integer
dim shared page_count as integer

sub display_init()
	
	con_width = loword(width())
	con_height = hiword(width())

	lrow = con_height
	bytes_per_page = (con_height - 2) * 16

end sub

sub display_redraw()	
	
	page_count = io_get_buffer_size(current_buffer) / bytes_per_page
	dim para_ct as integer = io_get_buffer_paragraph_count(current_buffer)
	
	color 0, 7
	cls
	locate 1, 1
	print "BINEDIT FILE: "; 
	color 12, 7
	print io_get_buffer_name(current_buffer);
	color 0, 7
	
	locate lrow, 1	
	print "BUF "; trim(str(current_buffer)); "/"; trim(str(io_get_buffer_count())); " | "; 
	print "BYTE "; trim(str(io_get_buffer_offset(current_buffer))); " "; trim(str(io_get_buffer_size(current_buffer))); " | PAGES "; trim(str(page_count));
	print " | PARAGRAPHS "; trim(str(para_ct));

	view print 2 to con_height - 1

	color 15, 1
	cls
	
	
	dim paragraph as integer
	for paragraph = io_get_buffer_paragraph(current_buffer) to para_ct - 1 		
	
		draw_paragraph paragraph
		if csrlin() >= con_height - 1 then 
			exit for
		else
			print ""
		end if
		
	next paragraph
		
end sub

sub draw_paragraph(paragraph as integer)

	dim i as integer
	dim b as byte
	dim offset as integer = paragraph * 16
	
	color 10, 1
	print "0x"; pad_left(hex(offset), "0", 5); ":  ";
	color 15, 1
	
	for i = offset to offset + 15
	
		if i = io_get_buffer_offset(current_buffer) then
			color 1, 15
		else
			color 15, 1
		end if
		
		print pad_left(trim(str(hex(io_get_byte(current_buffer, i)))), "0", 2);
		
		color 15, 1
		print " ";
		
	next i
	
	print "    | ";
	
	dim c as byte
	dim o as string
	
	for i = offset to offset + 15
		c = io_get_byte(current_buffer, i)
		
		if c > 31 and c < 127 then
			o = chr(c)
		else
			o = "."
		end if
		
		if i = io_get_buffer_offset(current_buffer) then
			color 1, 15
		else
			color 15, 1
		end if
		
		print o;
		
	next i
	
	color 15, 1

end sub

function pad_left(input_str as string, pad_char as string, total_size as integer) as string
	
	dim output_str as string
    dim diff as integer
    dim i as integer

    diff = total_size - len(input_str)

    for i = 1 to diff
		output_str = output_str & pad_char
    next

    output_str = output_str & input_str

    return output_str
    
end function

