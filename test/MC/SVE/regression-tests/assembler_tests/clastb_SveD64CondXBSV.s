// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
clastb  d0, p0, d0, z0.d  // 00000101-11101011-10000000-00000000
// CHECK: clastb  d0, p0, d0, z0.d // encoding: [0x00,0x80,0xeb,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11101011-10000000-00000000
CLASTB  D0, P0, D0, Z0.D  // 00000101-11101011-10000000-00000000
// CHECK: clastb  d0, p0, d0, z0.d // encoding: [0x00,0x80,0xeb,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11101011-10000000-00000000
clastb  d23, p3, d23, z13.d  // 00000101-11101011-10001101-10110111
// CHECK: clastb  d23, p3, d23, z13.d // encoding: [0xb7,0x8d,0xeb,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11101011-10001101-10110111
CLASTB  D23, P3, D23, Z13.D  // 00000101-11101011-10001101-10110111
// CHECK: clastb  d23, p3, d23, z13.d // encoding: [0xb7,0x8d,0xeb,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11101011-10001101-10110111
clastb  d21, p5, d21, z10.d  // 00000101-11101011-10010101-01010101
// CHECK: clastb  d21, p5, d21, z10.d // encoding: [0x55,0x95,0xeb,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11101011-10010101-01010101
CLASTB  D21, P5, D21, Z10.D  // 00000101-11101011-10010101-01010101
// CHECK: clastb  d21, p5, d21, z10.d // encoding: [0x55,0x95,0xeb,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11101011-10010101-01010101
clastb  d31, p7, d31, z31.d  // 00000101-11101011-10011111-11111111
// CHECK: clastb  d31, p7, d31, z31.d // encoding: [0xff,0x9f,0xeb,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11101011-10011111-11111111
CLASTB  D31, P7, D31, Z31.D  // 00000101-11101011-10011111-11111111
// CHECK: clastb  d31, p7, d31, z31.d // encoding: [0xff,0x9f,0xeb,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11101011-10011111-11111111
