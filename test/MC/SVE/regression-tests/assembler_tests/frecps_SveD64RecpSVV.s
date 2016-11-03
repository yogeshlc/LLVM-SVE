// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
frecps  z23.d, z13.d, z8.d  // 01100101-11001000-00011001-10110111
// CHECK: frecps  z23.d, z13.d, z8.d // encoding: [0xb7,0x19,0xc8,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11001000-00011001-10110111
FRECPS  Z23.D, Z13.D, Z8.D  // 01100101-11001000-00011001-10110111
// CHECK: frecps  z23.d, z13.d, z8.d // encoding: [0xb7,0x19,0xc8,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11001000-00011001-10110111
frecps  z31.d, z31.d, z31.d  // 01100101-11011111-00011011-11111111
// CHECK: frecps  z31.d, z31.d, z31.d // encoding: [0xff,0x1b,0xdf,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11011111-00011011-11111111
FRECPS  Z31.D, Z31.D, Z31.D  // 01100101-11011111-00011011-11111111
// CHECK: frecps  z31.d, z31.d, z31.d // encoding: [0xff,0x1b,0xdf,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11011111-00011011-11111111
frecps  z0.d, z0.d, z0.d  // 01100101-11000000-00011000-00000000
// CHECK: frecps  z0.d, z0.d, z0.d // encoding: [0x00,0x18,0xc0,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11000000-00011000-00000000
FRECPS  Z0.D, Z0.D, Z0.D  // 01100101-11000000-00011000-00000000
// CHECK: frecps  z0.d, z0.d, z0.d // encoding: [0x00,0x18,0xc0,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11000000-00011000-00000000
frecps  z21.d, z10.d, z21.d  // 01100101-11010101-00011001-01010101
// CHECK: frecps  z21.d, z10.d, z21.d // encoding: [0x55,0x19,0xd5,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010101-00011001-01010101
FRECPS  Z21.D, Z10.D, Z21.D  // 01100101-11010101-00011001-01010101
// CHECK: frecps  z21.d, z10.d, z21.d // encoding: [0x55,0x19,0xd5,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010101-00011001-01010101
