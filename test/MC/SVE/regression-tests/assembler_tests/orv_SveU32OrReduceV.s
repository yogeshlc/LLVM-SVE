// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
orv     s31, p7, z31.s  // 00000100-10011000-00111111-11111111
// CHECK: orv     s31, p7, z31.s // encoding: [0xff,0x3f,0x98,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10011000-00111111-11111111
ORV     S31, P7, Z31.S  // 00000100-10011000-00111111-11111111
// CHECK: orv     s31, p7, z31.s // encoding: [0xff,0x3f,0x98,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10011000-00111111-11111111
orv     s21, p5, z10.s  // 00000100-10011000-00110101-01010101
// CHECK: orv     s21, p5, z10.s // encoding: [0x55,0x35,0x98,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10011000-00110101-01010101
ORV     S21, P5, Z10.S  // 00000100-10011000-00110101-01010101
// CHECK: orv     s21, p5, z10.s // encoding: [0x55,0x35,0x98,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10011000-00110101-01010101
orv     s23, p3, z13.s  // 00000100-10011000-00101101-10110111
// CHECK: orv     s23, p3, z13.s // encoding: [0xb7,0x2d,0x98,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10011000-00101101-10110111
ORV     S23, P3, Z13.S  // 00000100-10011000-00101101-10110111
// CHECK: orv     s23, p3, z13.s // encoding: [0xb7,0x2d,0x98,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10011000-00101101-10110111
orv     s0, p0, z0.s  // 00000100-10011000-00100000-00000000
// CHECK: orv     s0, p0, z0.s // encoding: [0x00,0x20,0x98,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10011000-00100000-00000000
ORV     S0, P0, Z0.S  // 00000100-10011000-00100000-00000000
// CHECK: orv     s0, p0, z0.s // encoding: [0x00,0x20,0x98,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10011000-00100000-00000000
