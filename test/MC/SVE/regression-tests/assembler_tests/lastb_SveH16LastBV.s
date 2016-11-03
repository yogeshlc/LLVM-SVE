// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
lastb   h31, p7, z31.h  // 00000101-01100011-10011111-11111111
// CHECK: lastb   h31, p7, z31.h // encoding: [0xff,0x9f,0x63,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01100011-10011111-11111111
LASTB   H31, P7, Z31.H  // 00000101-01100011-10011111-11111111
// CHECK: lastb   h31, p7, z31.h // encoding: [0xff,0x9f,0x63,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01100011-10011111-11111111
lastb   h23, p3, z13.h  // 00000101-01100011-10001101-10110111
// CHECK: lastb   h23, p3, z13.h // encoding: [0xb7,0x8d,0x63,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01100011-10001101-10110111
LASTB   H23, P3, Z13.H  // 00000101-01100011-10001101-10110111
// CHECK: lastb   h23, p3, z13.h // encoding: [0xb7,0x8d,0x63,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01100011-10001101-10110111
lastb   h21, p5, z10.h  // 00000101-01100011-10010101-01010101
// CHECK: lastb   h21, p5, z10.h // encoding: [0x55,0x95,0x63,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01100011-10010101-01010101
LASTB   H21, P5, Z10.H  // 00000101-01100011-10010101-01010101
// CHECK: lastb   h21, p5, z10.h // encoding: [0x55,0x95,0x63,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01100011-10010101-01010101
lastb   h0, p0, z0.h  // 00000101-01100011-10000000-00000000
// CHECK: lastb   h0, p0, z0.h // encoding: [0x00,0x80,0x63,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01100011-10000000-00000000
LASTB   H0, P0, Z0.H  // 00000101-01100011-10000000-00000000
// CHECK: lastb   h0, p0, z0.h // encoding: [0x00,0x80,0x63,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01100011-10000000-00000000
