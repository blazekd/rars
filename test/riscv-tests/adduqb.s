.text
main:
  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

test_2:
 li x1, 0x00000000
 li x2, 0x00000000
 adduqb x30, x1, x2
 li x29, 0x00000000
 li gp, 2
 bne x30, x29, fail


test_3:
 li x1, 0x00000001
 li x2, 0x00000001
 adduqb x30, x1, x2
 li x29, 0x00000002
 li gp, 3
 bne x30, x29, fail


test_4:
 li x1, 0x00000003
 li x2, 0x00000007
 adduqb x30, x1, x2
 li x29, 0x0000000a
 li gp, 4
 bne x30, x29, fail



test_5:
 li x1, 0x00000000
 li x2, 0xffff8000
 adduqb x30, x1, x2
 li x29, 0xffff8000
 li gp, 5
 bne x30, x29, fail


test_6:
 li x1, 0x80000000
 li x2, 0x00000000
 adduqb x30, x1, x2
 li x29, 0x80000000
 li gp, 6
 bne x30, x29, fail


test_7:
 li x1, 0x80000000
 li x2, 0xffff8000
 adduqb x30, x1, x2
 li x29, 0x7fff8000
 li gp, 7
 bne x30, x29, fail



test_8:
 li x1, 0x00000000
 li x2, 0x00007fff
 adduqb x30, x1, x2
 li x29, 0x00007fff
 li gp, 8
 bne x30, x29, fail


test_9:
 li x1, 0x7fffffff
 li x2, 0x00000000
 adduqb x30, x1, x2
 li x29, 0x7fffffff
 li gp, 9
 bne x30, x29, fail


test_10:
 li x1, 0x7fffffff
 li x2, 0x00007fff
 adduqb x30, x1, x2
 li x29, 0x7fff7efe
 li gp, 10
 bne x30, x29, fail



test_11:
 li x1, 0x80000000
 li x2, 0x00007fff
 adduqb x30, x1, x2
 li x29, 0x80007fff
 li gp, 11
 bne x30, x29, fail


test_12:
 li x1, 0x7fffffff
 li x2, 0xffff8000
 adduqb x30, x1, x2
 li x29, 0x7efe7fff
 li gp, 12
 bne x30, x29, fail



test_13:
 li x1, 0x00000000
 li x2, 0xffffffff
 adduqb x30, x1, x2
 li x29, 0xffffffff
 li gp, 13
 bne x30, x29, fail


test_14:
 li x1, 0xffffffff
 li x2, 0x00000001
 adduqb x30, x1, x2
 li x29, 0xffffff00
 li gp, 14
 bne x30, x29, fail


test_15:
 li x1, 0xffffffff
 li x2, 0xffffffff
 adduqb x30, x1, x2
 li x29, 0xfefefefe
 li gp, 15
 bne x30, x29, fail



test_16:
 li x1, 0x00000001
 li x2, 0x7fffffff
 adduqb x30, x1, x2
 li x29, 0x7fffff00
 li gp, 16
 bne x30, x29, fail
 
 
test_17:
 li x1, 0x01010101
 li x2, 0xffffffff
 adduqb x30, x1, x2
 li x29, 0x00000000
 li gp, 16
 bne x30, x29, fail


test_18:
 li x1, 0x01000002
 li x2, 0xffef1ffe
 adduqb x30, x1, x2
 li x29, 0x00ef1f00
 li gp, 16
 bne x30, x29, fail
 
 test_19:
 li x1, 0x0100e002
 li x2, 0xffef1ffe
 adduqb x30, x1, x2
 li x29, 0x00efff00
 li gp, 16
 bne x30, x29, fail

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

test_20:
 li x1, 0x01010101
 li x2, 0x01020304
 adduqb x1, x1, x2
 li x29, 0x02030405
 li gp, 17
 bne x1, x29, fail


test_21:
 li x1, 0x00010203
 li x2, 0x010203ff
 adduqb x2, x1, x2
 li x29, 0x01030502
 li gp, 18
 bne x2, x29, fail


test_22:
 li x1, 0x0202ff02
 adduqb x1, x1, x1
 li x29, 0x0404fe04
 li gp, 19
 bne x1, x29, fail



pass:
	li a0, 42
	li a7, 93
	ecall
fail:
	li a0, 0
	li a7, 93
	ecall
