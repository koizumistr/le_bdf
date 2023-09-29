class CHAR

create {BDF}
   make

feature {ANY}
   make (x, y: INTEGER)
      do
         create bitmap.make(y, (x + 3) // 4)
      end

   bitmap: FAST_ARRAY2[INTEGER_8]

end -- class CHAR
