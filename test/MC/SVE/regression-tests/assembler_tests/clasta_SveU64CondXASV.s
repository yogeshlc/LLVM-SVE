// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
clasta  x23, p3, x23, z13.d  // 00000101-11110000-10101101-10110111
// CHECK: clasta  x23, p3, x23, z13.d // encoding: [0xb7,0xad,0xf0,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11110000-10101101-10110111
CLASTA  X23, P3, X23, Z13.D  // 00000101-11110000-10101101-10110111
// CHECK: clasta  x23, p3, x23, z13.d // encoding: [0xb7,0xad,0xf0,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11110000-10101101-10110111
clasta  x0, p0, x0, z0.d  // 00000101-11110000-10100000-00000000
// CHECK: clasta  x0, p0, x0, z0.d // encoding: [0x00,0xa0,0xf0,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11110000-10100000-00000000
CLASTA  X0, P0, X0, Z0.D  // 00000101-11110000-10100000-00000000
// CHECK: clasta  x0, p0, x0, z0.d // encoding: [0x00,0xa0,0xf0,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11110000-10100000-00000000
clasta  xzr, p7, xzr, z31.d  // 00000101-11110000-10111111-11111111
// CHECK: clasta  xzr, p7, xzr, z31.d // encoding: [0xff,0xbf,0xf0,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11110000-10111111-11111111
CLASTA  XZR, P7, XZR, Z31.D  // 00000101-11110000-10111111-11111111
// CHECK: clasta  xzr, p7, xzr, z31.d // encoding: [0xff,0xbf,0xf0,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11110000-10111111-11111111
clasta  x21, p5, x21, z10.d  // 00000101-11110000-10110101-01010101
// CHECK: clasta  x21, p5, x21, z10.d // encoding: [0x55,0xb5,0xf0,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11110000-10110101-01010101
CLASTA  X21, P5, X21, Z10.D  // 00000101-11110000-10110101-01010101
// CHECK: clasta  x21, p5, x21, z10.d // encoding: [0x55,0xb5,0xf0,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11110000-10110101-01010101
