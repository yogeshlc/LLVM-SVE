// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
clasta  d0, p0, d0, z0.d  // 00000101-11101010-10000000-00000000
// CHECK: clasta  d0, p0, d0, z0.d // encoding: [0x00,0x80,0xea,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11101010-10000000-00000000
CLASTA  D0, P0, D0, Z0.D  // 00000101-11101010-10000000-00000000
// CHECK: clasta  d0, p0, d0, z0.d // encoding: [0x00,0x80,0xea,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11101010-10000000-00000000
clasta  d23, p3, d23, z13.d  // 00000101-11101010-10001101-10110111
// CHECK: clasta  d23, p3, d23, z13.d // encoding: [0xb7,0x8d,0xea,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11101010-10001101-10110111
CLASTA  D23, P3, D23, Z13.D  // 00000101-11101010-10001101-10110111
// CHECK: clasta  d23, p3, d23, z13.d // encoding: [0xb7,0x8d,0xea,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11101010-10001101-10110111
clasta  d21, p5, d21, z10.d  // 00000101-11101010-10010101-01010101
// CHECK: clasta  d21, p5, d21, z10.d // encoding: [0x55,0x95,0xea,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11101010-10010101-01010101
CLASTA  D21, P5, D21, Z10.D  // 00000101-11101010-10010101-01010101
// CHECK: clasta  d21, p5, d21, z10.d // encoding: [0x55,0x95,0xea,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11101010-10010101-01010101
clasta  d31, p7, d31, z31.d  // 00000101-11101010-10011111-11111111
// CHECK: clasta  d31, p7, d31, z31.d // encoding: [0xff,0x9f,0xea,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11101010-10011111-11111111
CLASTA  D31, P7, D31, Z31.D  // 00000101-11101010-10011111-11111111
// CHECK: clasta  d31, p7, d31, z31.d // encoding: [0xff,0x9f,0xea,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11101010-10011111-11111111
