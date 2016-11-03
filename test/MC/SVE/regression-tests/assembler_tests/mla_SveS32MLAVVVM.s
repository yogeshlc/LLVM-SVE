// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
mla     z31.s, p7/m, z31.s, z31.s  // 00000100-10011111-01011111-11111111
// CHECK: mla     z31.s, p7/m, z31.s, z31.s // encoding: [0xff,0x5f,0x9f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10011111-01011111-11111111
MLA     Z31.S, P7/M, Z31.S, Z31.S  // 00000100-10011111-01011111-11111111
// CHECK: mla     z31.s, p7/m, z31.s, z31.s // encoding: [0xff,0x5f,0x9f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10011111-01011111-11111111
mla     z21.s, p5/m, z10.s, z21.s  // 00000100-10010101-01010101-01010101
// CHECK: mla     z21.s, p5/m, z10.s, z21.s // encoding: [0x55,0x55,0x95,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10010101-01010101-01010101
MLA     Z21.S, P5/M, Z10.S, Z21.S  // 00000100-10010101-01010101-01010101
// CHECK: mla     z21.s, p5/m, z10.s, z21.s // encoding: [0x55,0x55,0x95,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10010101-01010101-01010101
mla     z23.s, p3/m, z13.s, z8.s  // 00000100-10001000-01001101-10110111
// CHECK: mla     z23.s, p3/m, z13.s, z8.s // encoding: [0xb7,0x4d,0x88,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10001000-01001101-10110111
MLA     Z23.S, P3/M, Z13.S, Z8.S  // 00000100-10001000-01001101-10110111
// CHECK: mla     z23.s, p3/m, z13.s, z8.s // encoding: [0xb7,0x4d,0x88,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10001000-01001101-10110111
mla     z0.s, p0/m, z0.s, z0.s  // 00000100-10000000-01000000-00000000
// CHECK: mla     z0.s, p0/m, z0.s, z0.s // encoding: [0x00,0x40,0x80,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10000000-01000000-00000000
MLA     Z0.S, P0/M, Z0.S, Z0.S  // 00000100-10000000-01000000-00000000
// CHECK: mla     z0.s, p0/m, z0.s, z0.s // encoding: [0x00,0x40,0x80,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10000000-01000000-00000000
