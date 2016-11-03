// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
cmphi   p0.b, p0/z, z0.b, #0  // 00100100-00100000-00000000-00010000
// CHECK: cmphi   p0.b, p0/z, z0.b, #0 // encoding: [0x10,0x00,0x20,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-00100000-00000000-00010000
CMPHI   P0.B, P0/Z, Z0.B, #0  // 00100100-00100000-00000000-00010000
// CHECK: cmphi   p0.b, p0/z, z0.b, #0 // encoding: [0x10,0x00,0x20,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-00100000-00000000-00010000
cmphi   p15.b, p7/z, z31.b, #127  // 00100100-00111111-11011111-11111111
// CHECK: cmphi   p15.b, p7/z, z31.b, #127 // encoding: [0xff,0xdf,0x3f,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-00111111-11011111-11111111
CMPHI   P15.B, P7/Z, Z31.B, #127  // 00100100-00111111-11011111-11111111
// CHECK: cmphi   p15.b, p7/z, z31.b, #127 // encoding: [0xff,0xdf,0x3f,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-00111111-11011111-11111111
cmphi   p7.b, p3/z, z13.b, #35  // 00100100-00101000-11001101-10110111
// CHECK: cmphi   p7.b, p3/z, z13.b, #35 // encoding: [0xb7,0xcd,0x28,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-00101000-11001101-10110111
CMPHI   P7.B, P3/Z, Z13.B, #35  // 00100100-00101000-11001101-10110111
// CHECK: cmphi   p7.b, p3/z, z13.b, #35 // encoding: [0xb7,0xcd,0x28,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-00101000-11001101-10110111
cmphi   p5.b, p5/z, z10.b, #85  // 00100100-00110101-01010101-01010101
// CHECK: cmphi   p5.b, p5/z, z10.b, #85 // encoding: [0x55,0x55,0x35,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-00110101-01010101-01010101
CMPHI   P5.B, P5/Z, Z10.B, #85  // 00100100-00110101-01010101-01010101
// CHECK: cmphi   p5.b, p5/z, z10.b, #85 // encoding: [0x55,0x55,0x35,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-00110101-01010101-01010101
