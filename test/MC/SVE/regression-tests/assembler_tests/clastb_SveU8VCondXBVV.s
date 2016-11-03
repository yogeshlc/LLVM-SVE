// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
clastb  z0.b, p0, z0.b, z0.b  // 00000101-00101001-10000000-00000000
// CHECK: clastb  z0.b, p0, z0.b, z0.b // encoding: [0x00,0x80,0x29,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00101001-10000000-00000000
CLASTB  Z0.B, P0, Z0.B, Z0.B  // 00000101-00101001-10000000-00000000
// CHECK: clastb  z0.b, p0, z0.b, z0.b // encoding: [0x00,0x80,0x29,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00101001-10000000-00000000
clastb  z21.b, p5, z21.b, z10.b  // 00000101-00101001-10010101-01010101
// CHECK: clastb  z21.b, p5, z21.b, z10.b // encoding: [0x55,0x95,0x29,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00101001-10010101-01010101
CLASTB  Z21.B, P5, Z21.B, Z10.B  // 00000101-00101001-10010101-01010101
// CHECK: clastb  z21.b, p5, z21.b, z10.b // encoding: [0x55,0x95,0x29,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00101001-10010101-01010101
clastb  z31.b, p7, z31.b, z31.b  // 00000101-00101001-10011111-11111111
// CHECK: clastb  z31.b, p7, z31.b, z31.b // encoding: [0xff,0x9f,0x29,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00101001-10011111-11111111
CLASTB  Z31.B, P7, Z31.B, Z31.B  // 00000101-00101001-10011111-11111111
// CHECK: clastb  z31.b, p7, z31.b, z31.b // encoding: [0xff,0x9f,0x29,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00101001-10011111-11111111
clastb  z23.b, p3, z23.b, z13.b  // 00000101-00101001-10001101-10110111
// CHECK: clastb  z23.b, p3, z23.b, z13.b // encoding: [0xb7,0x8d,0x29,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00101001-10001101-10110111
CLASTB  Z23.B, P3, Z23.B, Z13.B  // 00000101-00101001-10001101-10110111
// CHECK: clastb  z23.b, p3, z23.b, z13.b // encoding: [0xb7,0x8d,0x29,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00101001-10001101-10110111
