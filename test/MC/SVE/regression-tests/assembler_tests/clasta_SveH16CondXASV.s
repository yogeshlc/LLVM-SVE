// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
clasta  h31, p7, h31, z31.h  // 00000101-01101010-10011111-11111111
// CHECK: clasta  h31, p7, h31, z31.h // encoding: [0xff,0x9f,0x6a,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101010-10011111-11111111
CLASTA  H31, P7, H31, Z31.H  // 00000101-01101010-10011111-11111111
// CHECK: clasta  h31, p7, h31, z31.h // encoding: [0xff,0x9f,0x6a,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101010-10011111-11111111
clasta  h23, p3, h23, z13.h  // 00000101-01101010-10001101-10110111
// CHECK: clasta  h23, p3, h23, z13.h // encoding: [0xb7,0x8d,0x6a,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101010-10001101-10110111
CLASTA  H23, P3, H23, Z13.H  // 00000101-01101010-10001101-10110111
// CHECK: clasta  h23, p3, h23, z13.h // encoding: [0xb7,0x8d,0x6a,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101010-10001101-10110111
clasta  h0, p0, h0, z0.h  // 00000101-01101010-10000000-00000000
// CHECK: clasta  h0, p0, h0, z0.h // encoding: [0x00,0x80,0x6a,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101010-10000000-00000000
CLASTA  H0, P0, H0, Z0.H  // 00000101-01101010-10000000-00000000
// CHECK: clasta  h0, p0, h0, z0.h // encoding: [0x00,0x80,0x6a,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101010-10000000-00000000
clasta  h21, p5, h21, z10.h  // 00000101-01101010-10010101-01010101
// CHECK: clasta  h21, p5, h21, z10.h // encoding: [0x55,0x95,0x6a,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101010-10010101-01010101
CLASTA  H21, P5, H21, Z10.H  // 00000101-01101010-10010101-01010101
// CHECK: clasta  h21, p5, h21, z10.h // encoding: [0x55,0x95,0x6a,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101010-10010101-01010101
