// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
cmplo   p15.h, p7/z, z31.h, #127  // 00100100-01111111-11111111-11101111
// CHECK: cmplo   p15.h, p7/z, z31.h, #127 // encoding: [0xef,0xff,0x7f,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-01111111-11111111-11101111
CMPLO   P15.H, P7/Z, Z31.H, #127  // 00100100-01111111-11111111-11101111
// CHECK: cmplo   p15.h, p7/z, z31.h, #127 // encoding: [0xef,0xff,0x7f,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-01111111-11111111-11101111
cmplo   p7.h, p3/z, z13.h, #35  // 00100100-01101000-11101101-10100111
// CHECK: cmplo   p7.h, p3/z, z13.h, #35 // encoding: [0xa7,0xed,0x68,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-01101000-11101101-10100111
CMPLO   P7.H, P3/Z, Z13.H, #35  // 00100100-01101000-11101101-10100111
// CHECK: cmplo   p7.h, p3/z, z13.h, #35 // encoding: [0xa7,0xed,0x68,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-01101000-11101101-10100111
cmplo   p0.h, p0/z, z0.h, #0  // 00100100-01100000-00100000-00000000
// CHECK: cmplo   p0.h, p0/z, z0.h, #0 // encoding: [0x00,0x20,0x60,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-01100000-00100000-00000000
CMPLO   P0.H, P0/Z, Z0.H, #0  // 00100100-01100000-00100000-00000000
// CHECK: cmplo   p0.h, p0/z, z0.h, #0 // encoding: [0x00,0x20,0x60,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-01100000-00100000-00000000
cmplo   p5.h, p5/z, z10.h, #85  // 00100100-01110101-01110101-01000101
// CHECK: cmplo   p5.h, p5/z, z10.h, #85 // encoding: [0x45,0x75,0x75,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-01110101-01110101-01000101
CMPLO   P5.H, P5/Z, Z10.H, #85  // 00100100-01110101-01110101-01000101
// CHECK: cmplo   p5.h, p5/z, z10.h, #85 // encoding: [0x45,0x75,0x75,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-01110101-01110101-01000101
