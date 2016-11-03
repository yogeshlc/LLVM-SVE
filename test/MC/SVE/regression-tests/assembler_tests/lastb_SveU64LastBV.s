// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
lastb   x21, p5, z10.d  // 00000101-11100001-10110101-01010101
// CHECK: lastb   x21, p5, z10.d // encoding: [0x55,0xb5,0xe1,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11100001-10110101-01010101
LASTB   X21, P5, Z10.D  // 00000101-11100001-10110101-01010101
// CHECK: lastb   x21, p5, z10.d // encoding: [0x55,0xb5,0xe1,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11100001-10110101-01010101
lastb   xzr, p7, z31.d  // 00000101-11100001-10111111-11111111
// CHECK: lastb   xzr, p7, z31.d // encoding: [0xff,0xbf,0xe1,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11100001-10111111-11111111
LASTB   XZR, P7, Z31.D  // 00000101-11100001-10111111-11111111
// CHECK: lastb   xzr, p7, z31.d // encoding: [0xff,0xbf,0xe1,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11100001-10111111-11111111
lastb   x0, p0, z0.d  // 00000101-11100001-10100000-00000000
// CHECK: lastb   x0, p0, z0.d // encoding: [0x00,0xa0,0xe1,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11100001-10100000-00000000
LASTB   X0, P0, Z0.D  // 00000101-11100001-10100000-00000000
// CHECK: lastb   x0, p0, z0.d // encoding: [0x00,0xa0,0xe1,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11100001-10100000-00000000
lastb   x23, p3, z13.d  // 00000101-11100001-10101101-10110111
// CHECK: lastb   x23, p3, z13.d // encoding: [0xb7,0xad,0xe1,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11100001-10101101-10110111
LASTB   X23, P3, Z13.D  // 00000101-11100001-10101101-10110111
// CHECK: lastb   x23, p3, z13.d // encoding: [0xb7,0xad,0xe1,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11100001-10101101-10110111
