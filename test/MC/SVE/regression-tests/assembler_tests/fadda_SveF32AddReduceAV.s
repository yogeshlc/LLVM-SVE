// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fadda   s23, p3, s23, z13.s  // 01100101-10011000-00101101-10110111
// CHECK: fadda   s23, p3, s23, z13.s // encoding: [0xb7,0x2d,0x98,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10011000-00101101-10110111
FADDA   S23, P3, S23, Z13.S  // 01100101-10011000-00101101-10110111
// CHECK: fadda   s23, p3, s23, z13.s // encoding: [0xb7,0x2d,0x98,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10011000-00101101-10110111
fadda   s31, p7, s31, z31.s  // 01100101-10011000-00111111-11111111
// CHECK: fadda   s31, p7, s31, z31.s // encoding: [0xff,0x3f,0x98,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10011000-00111111-11111111
FADDA   S31, P7, S31, Z31.S  // 01100101-10011000-00111111-11111111
// CHECK: fadda   s31, p7, s31, z31.s // encoding: [0xff,0x3f,0x98,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10011000-00111111-11111111
fadda   s21, p5, s21, z10.s  // 01100101-10011000-00110101-01010101
// CHECK: fadda   s21, p5, s21, z10.s // encoding: [0x55,0x35,0x98,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10011000-00110101-01010101
FADDA   S21, P5, S21, Z10.S  // 01100101-10011000-00110101-01010101
// CHECK: fadda   s21, p5, s21, z10.s // encoding: [0x55,0x35,0x98,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10011000-00110101-01010101
fadda   s0, p0, s0, z0.s  // 01100101-10011000-00100000-00000000
// CHECK: fadda   s0, p0, s0, z0.s // encoding: [0x00,0x20,0x98,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10011000-00100000-00000000
FADDA   S0, P0, S0, Z0.S  // 01100101-10011000-00100000-00000000
// CHECK: fadda   s0, p0, s0, z0.s // encoding: [0x00,0x20,0x98,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10011000-00100000-00000000
