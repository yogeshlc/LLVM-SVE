// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
clastb  z21.h, p5, z21.h, z10.h  // 00000101-01101001-10010101-01010101
// CHECK: clastb  z21.h, p5, z21.h, z10.h // encoding: [0x55,0x95,0x69,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101001-10010101-01010101
CLASTB  Z21.H, P5, Z21.H, Z10.H  // 00000101-01101001-10010101-01010101
// CHECK: clastb  z21.h, p5, z21.h, z10.h // encoding: [0x55,0x95,0x69,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101001-10010101-01010101
clastb  z23.h, p3, z23.h, z13.h  // 00000101-01101001-10001101-10110111
// CHECK: clastb  z23.h, p3, z23.h, z13.h // encoding: [0xb7,0x8d,0x69,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101001-10001101-10110111
CLASTB  Z23.H, P3, Z23.H, Z13.H  // 00000101-01101001-10001101-10110111
// CHECK: clastb  z23.h, p3, z23.h, z13.h // encoding: [0xb7,0x8d,0x69,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101001-10001101-10110111
clastb  z31.h, p7, z31.h, z31.h  // 00000101-01101001-10011111-11111111
// CHECK: clastb  z31.h, p7, z31.h, z31.h // encoding: [0xff,0x9f,0x69,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101001-10011111-11111111
CLASTB  Z31.H, P7, Z31.H, Z31.H  // 00000101-01101001-10011111-11111111
// CHECK: clastb  z31.h, p7, z31.h, z31.h // encoding: [0xff,0x9f,0x69,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101001-10011111-11111111
clastb  z0.h, p0, z0.h, z0.h  // 00000101-01101001-10000000-00000000
// CHECK: clastb  z0.h, p0, z0.h, z0.h // encoding: [0x00,0x80,0x69,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101001-10000000-00000000
CLASTB  Z0.H, P0, Z0.H, Z0.H  // 00000101-01101001-10000000-00000000
// CHECK: clastb  z0.h, p0, z0.h, z0.h // encoding: [0x00,0x80,0x69,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101001-10000000-00000000
