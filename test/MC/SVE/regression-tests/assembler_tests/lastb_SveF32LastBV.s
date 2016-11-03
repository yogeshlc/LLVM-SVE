// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
lastb   s23, p3, z13.s  // 00000101-10100011-10001101-10110111
// CHECK: lastb   s23, p3, z13.s // encoding: [0xb7,0x8d,0xa3,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10100011-10001101-10110111
LASTB   S23, P3, Z13.S  // 00000101-10100011-10001101-10110111
// CHECK: lastb   s23, p3, z13.s // encoding: [0xb7,0x8d,0xa3,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10100011-10001101-10110111
lastb   s21, p5, z10.s  // 00000101-10100011-10010101-01010101
// CHECK: lastb   s21, p5, z10.s // encoding: [0x55,0x95,0xa3,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10100011-10010101-01010101
LASTB   S21, P5, Z10.S  // 00000101-10100011-10010101-01010101
// CHECK: lastb   s21, p5, z10.s // encoding: [0x55,0x95,0xa3,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10100011-10010101-01010101
lastb   s0, p0, z0.s  // 00000101-10100011-10000000-00000000
// CHECK: lastb   s0, p0, z0.s // encoding: [0x00,0x80,0xa3,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10100011-10000000-00000000
LASTB   S0, P0, Z0.S  // 00000101-10100011-10000000-00000000
// CHECK: lastb   s0, p0, z0.s // encoding: [0x00,0x80,0xa3,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10100011-10000000-00000000
lastb   s31, p7, z31.s  // 00000101-10100011-10011111-11111111
// CHECK: lastb   s31, p7, z31.s // encoding: [0xff,0x9f,0xa3,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10100011-10011111-11111111
LASTB   S31, P7, Z31.S  // 00000101-10100011-10011111-11111111
// CHECK: lastb   s31, p7, z31.s // encoding: [0xff,0x9f,0xa3,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10100011-10011111-11111111
