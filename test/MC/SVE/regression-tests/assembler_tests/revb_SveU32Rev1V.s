// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
revb    z0.s, p0/m, z0.s  // 00000101-10100100-10000000-00000000
// CHECK: revb    z0.s, p0/m, z0.s // encoding: [0x00,0x80,0xa4,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10100100-10000000-00000000
REVB    Z0.S, P0/M, Z0.S  // 00000101-10100100-10000000-00000000
// CHECK: revb    z0.s, p0/m, z0.s // encoding: [0x00,0x80,0xa4,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10100100-10000000-00000000
revb    z31.s, p7/m, z31.s  // 00000101-10100100-10011111-11111111
// CHECK: revb    z31.s, p7/m, z31.s // encoding: [0xff,0x9f,0xa4,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10100100-10011111-11111111
REVB    Z31.S, P7/M, Z31.S  // 00000101-10100100-10011111-11111111
// CHECK: revb    z31.s, p7/m, z31.s // encoding: [0xff,0x9f,0xa4,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10100100-10011111-11111111
revb    z23.s, p3/m, z13.s  // 00000101-10100100-10001101-10110111
// CHECK: revb    z23.s, p3/m, z13.s // encoding: [0xb7,0x8d,0xa4,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10100100-10001101-10110111
REVB    Z23.S, P3/M, Z13.S  // 00000101-10100100-10001101-10110111
// CHECK: revb    z23.s, p3/m, z13.s // encoding: [0xb7,0x8d,0xa4,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10100100-10001101-10110111
revb    z21.s, p5/m, z10.s  // 00000101-10100100-10010101-01010101
// CHECK: revb    z21.s, p5/m, z10.s // encoding: [0x55,0x95,0xa4,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10100100-10010101-01010101
REVB    Z21.S, P5/M, Z10.S  // 00000101-10100100-10010101-01010101
// CHECK: revb    z21.s, p5/m, z10.s // encoding: [0x55,0x95,0xa4,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10100100-10010101-01010101
