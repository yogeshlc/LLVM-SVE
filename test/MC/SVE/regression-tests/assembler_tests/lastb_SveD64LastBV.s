// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
lastb   d23, p3, z13.d  // 00000101-11100011-10001101-10110111
// CHECK: lastb   d23, p3, z13.d // encoding: [0xb7,0x8d,0xe3,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11100011-10001101-10110111
LASTB   D23, P3, Z13.D  // 00000101-11100011-10001101-10110111
// CHECK: lastb   d23, p3, z13.d // encoding: [0xb7,0x8d,0xe3,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11100011-10001101-10110111
lastb   d0, p0, z0.d  // 00000101-11100011-10000000-00000000
// CHECK: lastb   d0, p0, z0.d // encoding: [0x00,0x80,0xe3,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11100011-10000000-00000000
LASTB   D0, P0, Z0.D  // 00000101-11100011-10000000-00000000
// CHECK: lastb   d0, p0, z0.d // encoding: [0x00,0x80,0xe3,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11100011-10000000-00000000
lastb   d31, p7, z31.d  // 00000101-11100011-10011111-11111111
// CHECK: lastb   d31, p7, z31.d // encoding: [0xff,0x9f,0xe3,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11100011-10011111-11111111
LASTB   D31, P7, Z31.D  // 00000101-11100011-10011111-11111111
// CHECK: lastb   d31, p7, z31.d // encoding: [0xff,0x9f,0xe3,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11100011-10011111-11111111
lastb   d21, p5, z10.d  // 00000101-11100011-10010101-01010101
// CHECK: lastb   d21, p5, z10.d // encoding: [0x55,0x95,0xe3,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11100011-10010101-01010101
LASTB   D21, P5, Z10.D  // 00000101-11100011-10010101-01010101
// CHECK: lastb   d21, p5, z10.d // encoding: [0x55,0x95,0xe3,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11100011-10010101-01010101
