/'
   io.bi
   
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

#define BUF_CLEAN 0
#define BUF_DIRTY 1

type buf
	file_path as string
	file_length as integer
	
	paragraph_count as integer
	
	paragraph as integer
	offset as integer
	
	state as byte
	
	content as byte ptr
end type

dim shared buffers(1) as buf
dim shared bufcount as integer

declare sub io_init()
declare sub io_check_buffers()

declare function io_open(filename as string) as integer

declare function io_new_buffer() as integer

declare function io_get_buffer_count() as integer
declare function io_get_buffer_name(bufidx as integer) as string
declare function io_get_buffer_size(bufidx as integer) as integer
declare function io_get_buffer_state(bufidx as integer) as byte

declare function io_get_byte(bufidx as integer, idx as integer) as byte
declare sub io_set_byte(bufidx as integer, idx as integer, value as byte)

declare function io_get_buffer_paragraph_count(bufidx as integer) as integer
declare function io_get_buffer_paragraph(bufidx as integer) as integer
declare sub io_set_buffer_paragraph(bufidx as integer, paragraph as integer)
declare sub io_inc_buffer_paragraph(bufidx as integer)
declare sub io_dec_buffer_paragraph(bufidx as integer)
declare function io_get_buffer_offset(bufidx as integer) as integer
declare sub io_set_buffer_offset(bufidx as integer, offset as integer)
declare sub io_inc_buffer_offset(bufidx as integer)
declare sub io_dec_buffer_offset(bufidx as integer)
