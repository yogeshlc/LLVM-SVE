// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
lastb   b21, p5, z10.b  // 00000101-00100011-10010101-01010101
// CHECK: lastb   b21, p5, z10.b // encoding: [0x55,0x95,0x23,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00100011-10010101-01010101
LASTB   B21, P5, Z10.B  // 00000101-00100011-10010101-01010101
// CHECK: lastb   b21, p5, z10.b // encoding: [0x55,0x95,0x23,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00100011-10010101-01010101
lastb   b0, p0, z0.b  // 00000101-00100011-10000000-00000000
// CHECK: lastb   b0, p0, z0.b // encoding: [0x00,0x80,0x23,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00100011-10000000-00000000
LASTB   B0, P0, Z0.B  // 00000101-00100011-10000000-00000000
// CHECK: lastb   b0, p0, z0.b // encoding: [0x00,0x80,0x23,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00100011-10000000-00000000
lastb   b23, p3, z13.b  // 00000101-00100011-10001101-10110111
// CHECK: lastb   b23, p3, z13.b // encoding: [0xb7,0x8d,0x23,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00100011-10001101-10110111
LASTB   B23, P3, Z13.B  // 00000101-00100011-10001101-10110111
// CHECK: lastb   b23, p3, z13.b // encoding: [0xb7,0x8d,0x23,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00100011-10001101-10110111
lastb   b31, p7, z31.b  // 00000101-00100011-10011111-11111111
// CHECK: lastb   b31, p7, z31.b // encoding: [0xff,0x9f,0x23,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00100011-10011111-11111111
LASTB   B31, P7, Z31.B  // 00000101-00100011-10011111-11111111
// CHECK: lastb   b31, p7, z31.b // encoding: [0xff,0x9f,0x23,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00100011-10011111-11111111
