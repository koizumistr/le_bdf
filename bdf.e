class BDF

create {ANY}
   from_file

feature {ANY}
   from_file (path: STRING)
      do
         bdf_path := path
         create f.connect_to(bdf_path)
      end

   is_connected: BOOLEAN
      do
         Result := f.is_connected
      end

   disconnect
      do
         f.disconnect
      end

   parse
      local
         state, i, j: INTEGER; d: INTEGER_8; val_arr: ARRAY[STRING]; c: CHAR
      do
--         std_output.put_string("full parse%N")
         from
            state := s_start
         until
            f.end_of_input or state = s_end
         loop
            f.read_line
            inspect
               state
            when s_start then
               if f.last_string.has_prefix("STARTFONT ") then
                  state := s_body
               else
                  std_output.put_string("Error - STARTFONT%N")
               end
            when s_body then
               if f.last_string.has_prefix("COMMENT ") or f.last_string.is_equal("COMMENT") then
                  -- ignore
               elseif f.last_string.has_prefix("FONT ") then
               elseif f.last_string.has_prefix("SIZE ") then
               elseif f.last_string.has_prefix("FONTBOUNDINGBOX ") then
                  f.last_string.remove_prefix("FONTBOUNDINGBOX ")
                  val_arr := f.last_string.split
                  ibbx := val_arr.item(val_arr.lower)
                  ibby := val_arr.item(val_arr.lower + 1)
               elseif f.last_string.has_prefix("STARTPROPERTIES ") then
                  state := s_properties
               elseif f.last_string.has_prefix("CHARS ") then
               elseif f.last_string.has_prefix("STARTCHAR ") then
                  state := s_char
               elseif f.last_string.is_equal("ENDFONT") then
                  state := s_end
               end
            when s_properties then
               if f.last_string.is_equal("ENDPROPERTIES") then
                  state := s_body
               end
            when s_char then
               if f.last_string.has_prefix("ENCODING ") then
                  f.last_string.remove_prefix("ENCODING ")
                  encoding := f.last_string.to_integer
               elseif f.last_string.has_prefix("SWIDTH ") then
               elseif f.last_string.has_prefix("DWIDTH ") then
               elseif f.last_string.is_equal("BITMAP") then
                  state := s_bitmap
                  create c.make(bbx, bby)
                  j := 0
               end
            when s_bitmap then
               if f.last_string.is_equal("ENDCHAR") then
                  state := s_body
                  table.put(c, encoding)
               else
                  from
                     i := f.last_string.lower
                  until
                     i > f.last_string.upper
                  loop
                     inspect
                        f.last_string.item(i)
                     when '0' then
                        d := 0x00
                     when '1' then
                        d := 0x01
                     when '2' then
                        d := 0x02
                     when '3' then
                        d := 0x03
                     when '4' then
                        d := 0x04
                     when '5' then
                        d := 0x05
                     when '6' then
                        d := 0x06
                     when '7' then
                        d := 0x07
                     when '8' then
                        d := 0x08
                     when '9' then
                        d := 0x09
                     when 'A' then
                        d := 0x0a
                     when 'a' then
                        d := 0x0a
                     when 'B' then
                        d := 0x0b
                     when 'b' then
                        d := 0x0b
                     when 'C' then
                        d := 0x0c
                     when 'c' then
                        d := 0x0c
                     when 'D' then
                        d := 0x0d
                     when 'd' then
                        d := 0x0d
                     when 'E' then
                        d := 0x0e
                     when 'e' then
                        d := 0x0e
                     when 'F' then
                        d := 0x0f
                     when 'f' then
                        d := 0x0f
                     end
                     c.bitmap.put(d, j, i - 1)
                     i := i + 1
                  end
                  j := j + 1
               end
            end
         end
      end

   bbx: INTEGER
      do
         if ibbx = Void then
            quick_parse
         end
         Result := ibbx.to_integer
      end

   bby: INTEGER
      do
         if ibby = Void then
            quick_parse
         end
         Result := ibby.to_integer
      end

   table: HASHED_DICTIONARY[CHAR, INTEGER]
      once
         create Result.make
      end

feature {}
   s_start, s_body, s_properties, s_char, s_bitmap, s_end: INTEGER unique

   f: TEXT_FILE_READ

   ibbx, ibby: STRING

   bdf_path: STRING

   encoding: INTEGER

   quick_parse
      local
         val_arr: ARRAY[STRING]
      do
--         std_output.put_string("quick parse%N")
         f.read_line
         from
         until
            f.end_of_input or ibbx /= Void
         loop
            f.read_line
            if f.last_string.has_prefix("FONTBOUNDINGBOX ") then
               f.last_string.remove_prefix("FONTBOUNDINGBOX ")
               val_arr := f.last_string.split
               ibbx := val_arr.item(val_arr.lower)
               ibby := val_arr.item(val_arr.lower + 1)
            end
         end

         f.disconnect
         create f.connect_to(bdf_path)
      end

end -- class BDF
