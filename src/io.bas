/'
   io.bas
   
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

#include "io.bi"
#include "lexer.bi"

sub io_init()

	bufcount = 1	
	redim buffers(bufcount) as buf	
	
end sub

sub io_check_buffers()

	dim i as integer
	
	for i = 0 to bufcount - 1
		if io_get_buffer_state(i) = BUF_DIRTY then
		
		end if
	next i
	
end sub

function io_open(filename as string) as integer

	dim buffer_index as integer
	buffer_index = io_new_buffer()

	dim filenum as integer	
	filenum = freefile()	
	
	dim c as byte

	dim i as integer

	open filename for binary as #filenum	
	
	with buffers(buffer_index)
		.file_path = filename
		.file_length = lof(filenum)
		.paragraph = 0
		.offset = 0
		.state = BUF_CLEAN
		.content = allocate(lof(filenum) * sizeof(byte))
	end with
	
	dim para_ct as integer = lof(filenum) / 16
	dim para_remainder as integer = lof(filenum) mod 16
	
	if para_remainder > 0 then para_ct += 1
	
	buffers(buffer_index).paragraph_count = para_ct
	
	for i = 0 to lof(filenum) - 1
		get #filenum, , c
		buffers(buffer_index).content[i] = c
	next i
	
	close #filenum
	
	return buffer_index
	
end function

function io_new_buffer() as integer
	bufcount = bufcount + 1
	redim preserve buffers(bufcount) as buf
	
	return bufcount - 1
end function

function io_get_buffer_count() as integer
	return bufcount - 1
end function

function io_get_buffer_name(bufidx as integer) as string
	return buffers(bufidx).file_path
end function

function io_get_buffer_size(bufidx as integer) as integer
	return buffers(bufidx).file_length
end function

function io_get_buffer_state(bufidx as integer) as byte
	return buffers(bufidx).state
end function

function io_get_byte(bufidx as integer, idx as integer) as byte
	return buffers(bufidx).content[idx]
end function

sub io_set_byte(bufidx as integer, idx as integer, value as byte)
	buffers(bufidx).content[idx] = value
	buffers(bufidx).state = BUF_DIRTY
end sub	

function io_get_buffer_paragraph_count(bufidx as integer) as integer
	return buffers(bufidx).paragraph_count
end function

function io_get_buffer_paragraph(bufidx as integer) as integer
	return buffers(bufidx).paragraph
end function

sub io_set_buffer_paragraph(bufidx as integer, paragraph as integer)
	buffers(bufidx).paragraph = paragraph
end sub

sub io_inc_buffer_paragraph(bufidx as integer)
	buffers(bufidx).paragraph += 1
end sub

sub io_dec_buffer_paragraph(bufidx as integer)
	buffers(bufidx).paragraph -= 1
end sub

function io_get_buffer_offset(bufidx as integer) as integer
	return buffers(bufidx).offset
end function

sub io_set_buffer_offset(bufidx as integer, offset as integer)
	buffers(bufidx).offset = offset
end sub

sub io_inc_buffer_offset(bufidx as integer)
	buffers(bufidx).offset += 1
end sub

sub io_dec_buffer_offset(bufidx as integer)
	buffers(bufidx).offset -= 1
end sub
