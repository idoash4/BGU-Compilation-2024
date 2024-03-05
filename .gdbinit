# switch to debugging c:
define clang
  tui enable
  set extended-prompt ido@clang (\w)>
  set tui border-mode standout
  set tui active-border-mode standout
  set tui border-kind acs
  layout src
  # to see assembly too:
  # layout split
  # set disassembly-flavor intel
end

# switch to debugging assembly-language:
define asm
  set extended-prompt ido@asm (\w)>
  set disassembly-flavor intel
  tui reg all
  set tui border-mode standout
  set tui active-border-mode standout
  set tui border-kind acs
  layout asm
  layout regs
end

define pstack
  p/x *(unsigned long *)$rsp@20
end

define ssi
  si
  p/x *(unsigned long *)$rsp@20
end

define go
  b main
  continue
end

define scm_type
  set $rtti = (int)*(char *)$arg0
  if $rtti == 0
    printf "RTTI = 0 (T_void)\n"
  else
    if $rtti == 1
      printf "RTTI = 1 (T_nil)\n"
    else
      if $rtti == 2
	printf "RTTI = 2 (T_char)\n"
        set $val = (int)*(char *)(1 + $arg0)
        printf "VALUE = ASCII (%d) '%c' \n", $val, (char) $val
      else
	if $rtti == 3
          set $len = *(unsigned long *)(1 + (unsigned long)$arg0)
	  printf "RTTI = 3 (T_string)\n"
	  printf "LENGTH = %ld\n", $len
          p *(char *)(1 + 8 + (unsigned long)$arg0)@$len
	else
	  if $rtti == 4
	    printf "RTTI = 4 (T_closure)\n"
	    printf "ENV = 0x%lx\n", *(unsigned long *)(1 + (unsigned long)$arg0)
	    printf "CODE = 0x%lx\n", *(unsigned long *)(1 + 8 + (unsigned long)$arg0)
	  else
	    if $rtti == 5
	      printf "RTTI = 5 (T_undefined)\n"
	      printf "FREE VAR PRINT-STRING = 0x%lx\n", *(unsigned long *)(1 + (unsigned long)$arg0)
	    else
	      if $rtti == 8
		printf "RTTI = 8 (T_boolean)\n"
		printf "This is an abstract type; Should not have instances!\n"
	      else
		if $rtti == 9
		  printf "RTTI = 9 (T_false)\n"
		else
		  if $rtti == 10
		    printf "RTTI = 10 (T_true)\n"
		  else
		    if $rtti == 16
		      printf "RTTI = 16 (T_number)\n"
		      printf "This is an abstract type; Should not have instances!\n"
		    else
		      if $rtti == 17
			printf "RTTI = 17 (T_integer)\n"
			printf "VALUE = %ld\n", *(unsigned long *)(1 + (unsigned long)$arg0)
		      else
			if $rtti == 18
			  printf "RTTI = 18 (T_fraction)\n"
			  printf "NUMERATOR = %ld\n", *(unsigned long *)(1 + (unsigned long)$arg0)
			  printf "DENOMINATOR = %ld\n", *(unsigned long *)(1 + 8 + (unsigned long)$arg0)
			else
			  if $rtti == 19
			    printf "RTTI = 19 (T_real)\n"
			    printf "VALUE = %f\n", *(unsigned long *)(1 + (unsigned long)$arg0)
			  else
			    if $rtti == 32
			      printf "RTTI = 32 (T_collection)\n"
			      printf "This is an abstract type; Should not have instances!\n"
			    else
			      if $rtti == 33
				printf "RTTI = 33 (T_pair)\n"
			 	printf "CAR = 0x%lx\n", *(unsigned long *)(1 + (unsigned long)$arg0)
				printf "CDR = 0x%lx\n", *(unsigned long *)(1 + 8 + (unsigned long)$arg0)
			      else
				if $rtti == 34
				  printf "RTTI = 34 (T_vector)\n"
				  set $len = *(unsigned long *)(1 + (unsigned long)$arg0)
				  set $base = (unsigned long *)(1 + 8 + (unsigned long)$arg0)
				  printf "LENGTH = %ld\n", $len
				  p/x *(unsigned long *)$base@$len
				else
				  if $rtti == 64
				    printf "RTTI = 64 (T_symbol)\n"
				    printf "This is an abstract type; Should not have instances!\n"
				  else
				    if $rtti == 65
				      printf "RTTI = 65 (T_interned_symbol)\n"
				      printf "PRINT-STRING = 0x%lx\n", *(unsigned long *)(1 + (unsigned long)$arg0)
				    else
				      if $rtti == 66
					printf "RTTI = 66 (T_uninterned_symbol)\n"
					printf "GENSYM-COUNT = %ld\n", *(unsigned long *)(1 + (unsigned long)$arg0)
				      else
					printf "Not a valid RTTI --- Not an sexpr!\n"
				      end
				    end
				  end
				end
			      end
			    end
			  end
			end
		      end
		    end
		  end
		end
	      end
	    end
	  end
	end
      end
    end
  end
end