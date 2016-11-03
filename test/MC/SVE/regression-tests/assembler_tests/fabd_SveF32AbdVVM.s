// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fabd    z23.s, p3/m, z23.s, z13.s  // 01100101-10001000-10001101-10110111
// CHECK: fabd    z23.s, p3/m, z23.s, z13.s // encoding: [0xb7,0x8d,0x88,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10001000-10001101-10110111
FABD    Z23.S, P3/M, Z23.S, Z13.S  // 01100101-10001000-10001101-10110111
// CHECK: fabd    z23.s, p3/m, z23.s, z13.s // encoding: [0xb7,0x8d,0x88,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10001000-10001101-10110111
fabd    z31.s, p7/m, z31.s, z31.s  // 01100101-10001000-10011111-11111111
// CHECK: fabd    z31.s, p7/m, z31.s, z31.s // encoding: [0xff,0x9f,0x88,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10001000-10011111-11111111
FABD    Z31.S, P7/M, Z31.S, Z31.S  // 01100101-10001000-10011111-11111111
// CHECK: fabd    z31.s, p7/m, z31.s, z31.s // encoding: [0xff,0x9f,0x88,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10001000-10011111-11111111
fabd    z21.s, p5/m, z21.s, z10.s  // 01100101-10001000-10010101-01010101
// CHECK: fabd    z21.s, p5/m, z21.s, z10.s // encoding: [0x55,0x95,0x88,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10001000-10010101-01010101
FABD    Z21.S, P5/M, Z21.S, Z10.S  // 01100101-10001000-10010101-01010101
// CHECK: fabd    z21.s, p5/m, z21.s, z10.s // encoding: [0x55,0x95,0x88,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10001000-10010101-01010101
fabd    z0.s, p0/m, z0.s, z0.s  // 01100101-10001000-10000000-00000000
// CHECK: fabd    z0.s, p0/m, z0.s, z0.s // encoding: [0x00,0x80,0x88,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10001000-10000000-00000000
FABD    Z0.S, P0/M, Z0.S, Z0.S  // 01100101-10001000-10000000-00000000
// CHECK: fabd    z0.s, p0/m, z0.s, z0.s // encoding: [0x00,0x80,0x88,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10001000-10000000-00000000
