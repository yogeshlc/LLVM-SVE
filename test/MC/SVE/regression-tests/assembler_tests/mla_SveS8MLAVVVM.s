// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
mla     z23.b, p3/m, z13.b, z8.b  // 00000100-00001000-01001101-10110111
// CHECK: mla     z23.b, p3/m, z13.b, z8.b // encoding: [0xb7,0x4d,0x08,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00001000-01001101-10110111
MLA     Z23.B, P3/M, Z13.B, Z8.B  // 00000100-00001000-01001101-10110111
// CHECK: mla     z23.b, p3/m, z13.b, z8.b // encoding: [0xb7,0x4d,0x08,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00001000-01001101-10110111
mla     z0.b, p0/m, z0.b, z0.b  // 00000100-00000000-01000000-00000000
// CHECK: mla     z0.b, p0/m, z0.b, z0.b // encoding: [0x00,0x40,0x00,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00000000-01000000-00000000
MLA     Z0.B, P0/M, Z0.B, Z0.B  // 00000100-00000000-01000000-00000000
// CHECK: mla     z0.b, p0/m, z0.b, z0.b // encoding: [0x00,0x40,0x00,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00000000-01000000-00000000
mla     z31.b, p7/m, z31.b, z31.b  // 00000100-00011111-01011111-11111111
// CHECK: mla     z31.b, p7/m, z31.b, z31.b // encoding: [0xff,0x5f,0x1f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00011111-01011111-11111111
MLA     Z31.B, P7/M, Z31.B, Z31.B  // 00000100-00011111-01011111-11111111
// CHECK: mla     z31.b, p7/m, z31.b, z31.b // encoding: [0xff,0x5f,0x1f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00011111-01011111-11111111
mla     z21.b, p5/m, z10.b, z21.b  // 00000100-00010101-01010101-01010101
// CHECK: mla     z21.b, p5/m, z10.b, z21.b // encoding: [0x55,0x55,0x15,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00010101-01010101-01010101
MLA     Z21.B, P5/M, Z10.B, Z21.B  // 00000100-00010101-01010101-01010101
// CHECK: mla     z21.b, p5/m, z10.b, z21.b // encoding: [0x55,0x55,0x15,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00010101-01010101-01010101
