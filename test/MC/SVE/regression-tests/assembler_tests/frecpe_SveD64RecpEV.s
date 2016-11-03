// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
frecpe  z31.d, z31.d  // 01100101-11001110-00110011-11111111
// CHECK: frecpe  z31.d, z31.d // encoding: [0xff,0x33,0xce,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11001110-00110011-11111111
FRECPE  Z31.D, Z31.D  // 01100101-11001110-00110011-11111111
// CHECK: frecpe  z31.d, z31.d // encoding: [0xff,0x33,0xce,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11001110-00110011-11111111
frecpe  z21.d, z10.d  // 01100101-11001110-00110001-01010101
// CHECK: frecpe  z21.d, z10.d // encoding: [0x55,0x31,0xce,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11001110-00110001-01010101
FRECPE  Z21.D, Z10.D  // 01100101-11001110-00110001-01010101
// CHECK: frecpe  z21.d, z10.d // encoding: [0x55,0x31,0xce,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11001110-00110001-01010101
frecpe  z23.d, z13.d  // 01100101-11001110-00110001-10110111
// CHECK: frecpe  z23.d, z13.d // encoding: [0xb7,0x31,0xce,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11001110-00110001-10110111
FRECPE  Z23.D, Z13.D  // 01100101-11001110-00110001-10110111
// CHECK: frecpe  z23.d, z13.d // encoding: [0xb7,0x31,0xce,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11001110-00110001-10110111
frecpe  z0.d, z0.d  // 01100101-11001110-00110000-00000000
// CHECK: frecpe  z0.d, z0.d // encoding: [0x00,0x30,0xce,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11001110-00110000-00000000
FRECPE  Z0.D, Z0.D  // 01100101-11001110-00110000-00000000
// CHECK: frecpe  z0.d, z0.d // encoding: [0x00,0x30,0xce,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11001110-00110000-00000000
