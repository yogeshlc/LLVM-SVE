// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
mls     z23.s, p3/m, z13.s, z8.s  // 00000100-10001000-01101101-10110111
// CHECK: mls     z23.s, p3/m, z13.s, z8.s // encoding: [0xb7,0x6d,0x88,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10001000-01101101-10110111
MLS     Z23.S, P3/M, Z13.S, Z8.S  // 00000100-10001000-01101101-10110111
// CHECK: mls     z23.s, p3/m, z13.s, z8.s // encoding: [0xb7,0x6d,0x88,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10001000-01101101-10110111
mls     z21.s, p5/m, z10.s, z21.s  // 00000100-10010101-01110101-01010101
// CHECK: mls     z21.s, p5/m, z10.s, z21.s // encoding: [0x55,0x75,0x95,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10010101-01110101-01010101
MLS     Z21.S, P5/M, Z10.S, Z21.S  // 00000100-10010101-01110101-01010101
// CHECK: mls     z21.s, p5/m, z10.s, z21.s // encoding: [0x55,0x75,0x95,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10010101-01110101-01010101
mls     z31.s, p7/m, z31.s, z31.s  // 00000100-10011111-01111111-11111111
// CHECK: mls     z31.s, p7/m, z31.s, z31.s // encoding: [0xff,0x7f,0x9f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10011111-01111111-11111111
MLS     Z31.S, P7/M, Z31.S, Z31.S  // 00000100-10011111-01111111-11111111
// CHECK: mls     z31.s, p7/m, z31.s, z31.s // encoding: [0xff,0x7f,0x9f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10011111-01111111-11111111
mls     z0.s, p0/m, z0.s, z0.s  // 00000100-10000000-01100000-00000000
// CHECK: mls     z0.s, p0/m, z0.s, z0.s // encoding: [0x00,0x60,0x80,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10000000-01100000-00000000
MLS     Z0.S, P0/M, Z0.S, Z0.S  // 00000100-10000000-01100000-00000000
// CHECK: mls     z0.s, p0/m, z0.s, z0.s // encoding: [0x00,0x60,0x80,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10000000-01100000-00000000
