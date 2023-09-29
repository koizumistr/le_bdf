class BDF_TEST

insert
   ARGUMENTS

create {ANY}
   make

feature {ANY}
   make
      do
         create bdf.from_file(argument(1))
         if bdf.is_connected then
            std_output.put_integer(bdf.bbx)
            bdf.parse
            std_output.put_integer(bdf.bby)
            bdf.disconnect
            std_output.put_new_line

--            bdf.table.for_each(agent print_key_value(?, ?))

            print_char(0x2433) -- こ
            print_char(0x2473) -- ん
            print_char(0x244b) -- に
            print_char(0x2441) -- ち
            print_char(0x244f) -- は

            print_char(0x48) -- H
            print_char(0x69) -- i
            print_char(0x21) -- !
         end
      end

   bdf: BDF

   print_char (code: INTEGER)
      local
         m, n: INTEGER; value: CHAR
      do
         if bdf.table.fast_has(code) then
            std_output.put_new_line
            std_output.put_integer(code)
            std_output.put_string(" " + code.to_hexadecimal)
            std_output.put_character('%N')
            value := bdf.table.fast_at(code)
            from
               m := value.bitmap.lower1
            until
               m > value.bitmap.upper1
            loop
               from
                  n := value.bitmap.lower2
               until
                  n > value.bitmap.upper2
               loop
                  inspect
                     value.bitmap.item(m, n)
                  when 0x00 then
                     std_output.put_string("0000")
                  when 0x01 then
                     std_output.put_string("0001")
                  when 0x02 then
                     std_output.put_string("0010")
                  when 0x03 then
                     std_output.put_string("0011")
                  when 0x04 then
                     std_output.put_string("0100")
                  when 0x05 then
                     std_output.put_string("0101")
                  when 0x06 then
                     std_output.put_string("0110")
                  when 0x07 then
                     std_output.put_string("0111")
                  when 0x08 then
                     std_output.put_string("1000")
                  when 0x09 then
                     std_output.put_string("1001")
                  when 0x0a then
                     std_output.put_string("1010")
                  when 0x0b then
                     std_output.put_string("1011")
                  when 0x0c then
                     std_output.put_string("1100")
                  when 0x0d then
                     std_output.put_string("1101")
                  when 0x0e then
                     std_output.put_string("1110")
                  when 0x0f then
                     std_output.put_string("1111")
                  end
                  n := n + 1
               end
               std_output.put_new_line
               m := m + 1
            end

            std_output.put_new_line
         else
            std_output.put_string("No glyph!%N")
         end
      end

   print_key_value (value: CHAR; key: INTEGER)
      local
         m, n: INTEGER
      do
         std_output.put_new_line
         std_output.put_integer(key)
         std_output.put_string(" " + key.to_hexadecimal)
         std_output.put_character('%N')
         from
            m := value.bitmap.lower1
         until
            m > value.bitmap.upper1
         loop
            from
               n := value.bitmap.lower2
            until
               n > value.bitmap.upper2
            loop
               inspect
                  value.bitmap.item(m, n)
               when 0x00 then
                  std_output.put_string("0000")
               when 0x01 then
                  std_output.put_string("0001")
               when 0x02 then
                  std_output.put_string("0010")
               when 0x03 then
                  std_output.put_string("0011")
               when 0x04 then
                  std_output.put_string("0100")
               when 0x05 then
                  std_output.put_string("0101")
               when 0x06 then
                  std_output.put_string("0110")
               when 0x07 then
                  std_output.put_string("0111")
               when 0x08 then
                  std_output.put_string("1000")
               when 0x09 then
                  std_output.put_string("1001")
               when 0x0a then
                  std_output.put_string("1010")
               when 0x0b then
                  std_output.put_string("1011")
               when 0x0c then
                  std_output.put_string("1100")
               when 0x0d then
                  std_output.put_string("1101")
               when 0x0e then
                  std_output.put_string("1110")
               when 0x0f then
                  std_output.put_string("1111")
               end
               n := n + 1
            end
            std_output.put_new_line
            m := m + 1
         end

         std_output.put_new_line
      end

end -- class BDF_TEST
