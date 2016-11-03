// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
frecpe  z31.s, z31.s  // 01100101-10001110-00110011-11111111
// CHECK: frecpe  z31.s, z31.s // encoding: [0xff,0x33,0x8e,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10001110-00110011-11111111
FRECPE  Z31.S, Z31.S  // 01100101-10001110-00110011-11111111
// CHECK: frecpe  z31.s, z31.s // encoding: [0xff,0x33,0x8e,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10001110-00110011-11111111
frecpe  z23.s, z13.s  // 01100101-10001110-00110001-10110111
// CHECK: frecpe  z23.s, z13.s // encoding: [0xb7,0x31,0x8e,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10001110-00110001-10110111
FRECPE  Z23.S, Z13.S  // 01100101-10001110-00110001-10110111
// CHECK: frecpe  z23.s, z13.s // encoding: [0xb7,0x31,0x8e,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10001110-00110001-10110111
frecpe  z0.s, z0.s  // 01100101-10001110-00110000-00000000
// CHECK: frecpe  z0.s, z0.s // encoding: [0x00,0x30,0x8e,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10001110-00110000-00000000
FRECPE  Z0.S, Z0.S  // 01100101-10001110-00110000-00000000
// CHECK: frecpe  z0.s, z0.s // encoding: [0x00,0x30,0x8e,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10001110-00110000-00000000
frecpe  z21.s, z10.s  // 01100101-10001110-00110001-01010101
// CHECK: frecpe  z21.s, z10.s // encoding: [0x55,0x31,0x8e,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10001110-00110001-01010101
FRECPE  Z21.S, Z10.S  // 01100101-10001110-00110001-01010101
// CHECK: frecpe  z21.s, z10.s // encoding: [0x55,0x31,0x8e,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10001110-00110001-01010101
