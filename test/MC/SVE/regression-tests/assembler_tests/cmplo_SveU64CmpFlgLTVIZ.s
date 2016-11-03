// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
cmplo   p15.d, p7/z, z31.d, #127  // 00100100-11111111-11111111-11101111
// CHECK: cmplo   p15.d, p7/z, z31.d, #127 // encoding: [0xef,0xff,0xff,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-11111111-11111111-11101111
CMPLO   P15.D, P7/Z, Z31.D, #127  // 00100100-11111111-11111111-11101111
// CHECK: cmplo   p15.d, p7/z, z31.d, #127 // encoding: [0xef,0xff,0xff,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-11111111-11111111-11101111
cmplo   p0.d, p0/z, z0.d, #0  // 00100100-11100000-00100000-00000000
// CHECK: cmplo   p0.d, p0/z, z0.d, #0 // encoding: [0x00,0x20,0xe0,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-11100000-00100000-00000000
CMPLO   P0.D, P0/Z, Z0.D, #0  // 00100100-11100000-00100000-00000000
// CHECK: cmplo   p0.d, p0/z, z0.d, #0 // encoding: [0x00,0x20,0xe0,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-11100000-00100000-00000000
cmplo   p5.d, p5/z, z10.d, #85  // 00100100-11110101-01110101-01000101
// CHECK: cmplo   p5.d, p5/z, z10.d, #85 // encoding: [0x45,0x75,0xf5,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-11110101-01110101-01000101
CMPLO   P5.D, P5/Z, Z10.D, #85  // 00100100-11110101-01110101-01000101
// CHECK: cmplo   p5.d, p5/z, z10.d, #85 // encoding: [0x45,0x75,0xf5,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-11110101-01110101-01000101
cmplo   p7.d, p3/z, z13.d, #35  // 00100100-11101000-11101101-10100111
// CHECK: cmplo   p7.d, p3/z, z13.d, #35 // encoding: [0xa7,0xed,0xe8,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-11101000-11101101-10100111
CMPLO   P7.D, P3/Z, Z13.D, #35  // 00100100-11101000-11101101-10100111
// CHECK: cmplo   p7.d, p3/z, z13.d, #35 // encoding: [0xa7,0xed,0xe8,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-11101000-11101101-10100111
