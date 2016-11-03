// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
cmplo   p7.s, p3/z, z13.s, z8.d  // 00100100-10001000-11101101-10100111
// CHECK: cmplo   p7.s, p3/z, z13.s, z8.d // encoding: [0xa7,0xed,0x88,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-10001000-11101101-10100111
CMPLO   P7.S, P3/Z, Z13.S, Z8.D  // 00100100-10001000-11101101-10100111
// CHECK: cmplo   p7.s, p3/z, z13.s, z8.d // encoding: [0xa7,0xed,0x88,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-10001000-11101101-10100111
cmplo   p5.s, p5/z, z10.s, z21.d  // 00100100-10010101-11110101-01000101
// CHECK: cmplo   p5.s, p5/z, z10.s, z21.d // encoding: [0x45,0xf5,0x95,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-10010101-11110101-01000101
CMPLO   P5.S, P5/Z, Z10.S, Z21.D  // 00100100-10010101-11110101-01000101
// CHECK: cmplo   p5.s, p5/z, z10.s, z21.d // encoding: [0x45,0xf5,0x95,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-10010101-11110101-01000101
cmplo   p0.s, p0/z, z0.s, z0.d  // 00100100-10000000-11100000-00000000
// CHECK: cmplo   p0.s, p0/z, z0.s, z0.d // encoding: [0x00,0xe0,0x80,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-10000000-11100000-00000000
CMPLO   P0.S, P0/Z, Z0.S, Z0.D  // 00100100-10000000-11100000-00000000
// CHECK: cmplo   p0.s, p0/z, z0.s, z0.d // encoding: [0x00,0xe0,0x80,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-10000000-11100000-00000000
cmplo   p15.s, p7/z, z31.s, z31.d  // 00100100-10011111-11111111-11101111
// CHECK: cmplo   p15.s, p7/z, z31.s, z31.d // encoding: [0xef,0xff,0x9f,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-10011111-11111111-11101111
CMPLO   P15.S, P7/Z, Z31.S, Z31.D  // 00100100-10011111-11111111-11101111
// CHECK: cmplo   p15.s, p7/z, z31.s, z31.d // encoding: [0xef,0xff,0x9f,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-10011111-11111111-11101111
