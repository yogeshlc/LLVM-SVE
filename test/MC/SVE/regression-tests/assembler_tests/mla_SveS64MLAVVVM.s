// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
mla     z31.d, p7/m, z31.d, z31.d  // 00000100-11011111-01011111-11111111
// CHECK: mla     z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0x5f,0xdf,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11011111-01011111-11111111
MLA     Z31.D, P7/M, Z31.D, Z31.D  // 00000100-11011111-01011111-11111111
// CHECK: mla     z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0x5f,0xdf,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11011111-01011111-11111111
mla     z21.d, p5/m, z10.d, z21.d  // 00000100-11010101-01010101-01010101
// CHECK: mla     z21.d, p5/m, z10.d, z21.d // encoding: [0x55,0x55,0xd5,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11010101-01010101-01010101
MLA     Z21.D, P5/M, Z10.D, Z21.D  // 00000100-11010101-01010101-01010101
// CHECK: mla     z21.d, p5/m, z10.d, z21.d // encoding: [0x55,0x55,0xd5,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11010101-01010101-01010101
mla     z23.d, p3/m, z13.d, z8.d  // 00000100-11001000-01001101-10110111
// CHECK: mla     z23.d, p3/m, z13.d, z8.d // encoding: [0xb7,0x4d,0xc8,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11001000-01001101-10110111
MLA     Z23.D, P3/M, Z13.D, Z8.D  // 00000100-11001000-01001101-10110111
// CHECK: mla     z23.d, p3/m, z13.d, z8.d // encoding: [0xb7,0x4d,0xc8,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11001000-01001101-10110111
mla     z0.d, p0/m, z0.d, z0.d  // 00000100-11000000-01000000-00000000
// CHECK: mla     z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0x40,0xc0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11000000-01000000-00000000
MLA     Z0.D, P0/M, Z0.D, Z0.D  // 00000100-11000000-01000000-00000000
// CHECK: mla     z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0x40,0xc0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11000000-01000000-00000000
