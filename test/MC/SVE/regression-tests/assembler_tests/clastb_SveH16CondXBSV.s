// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
clastb  h23, p3, h23, z13.h  // 00000101-01101011-10001101-10110111
// CHECK: clastb  h23, p3, h23, z13.h // encoding: [0xb7,0x8d,0x6b,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101011-10001101-10110111
CLASTB  H23, P3, H23, Z13.H  // 00000101-01101011-10001101-10110111
// CHECK: clastb  h23, p3, h23, z13.h // encoding: [0xb7,0x8d,0x6b,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101011-10001101-10110111
clastb  h21, p5, h21, z10.h  // 00000101-01101011-10010101-01010101
// CHECK: clastb  h21, p5, h21, z10.h // encoding: [0x55,0x95,0x6b,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101011-10010101-01010101
CLASTB  H21, P5, H21, Z10.H  // 00000101-01101011-10010101-01010101
// CHECK: clastb  h21, p5, h21, z10.h // encoding: [0x55,0x95,0x6b,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101011-10010101-01010101
clastb  h0, p0, h0, z0.h  // 00000101-01101011-10000000-00000000
// CHECK: clastb  h0, p0, h0, z0.h // encoding: [0x00,0x80,0x6b,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101011-10000000-00000000
CLASTB  H0, P0, H0, Z0.H  // 00000101-01101011-10000000-00000000
// CHECK: clastb  h0, p0, h0, z0.h // encoding: [0x00,0x80,0x6b,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101011-10000000-00000000
clastb  h31, p7, h31, z31.h  // 00000101-01101011-10011111-11111111
// CHECK: clastb  h31, p7, h31, z31.h // encoding: [0xff,0x9f,0x6b,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101011-10011111-11111111
CLASTB  H31, P7, H31, Z31.H  // 00000101-01101011-10011111-11111111
// CHECK: clastb  h31, p7, h31, z31.h // encoding: [0xff,0x9f,0x6b,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101011-10011111-11111111
