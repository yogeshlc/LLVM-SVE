// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
facgt   p7.s, p3/z, z13.s, z8.s  // 01100101-10001000-11101101-10110111
// CHECK: facgt   p7.s, p3/z, z13.s, z8.s // encoding: [0xb7,0xed,0x88,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10001000-11101101-10110111
FACGT   P7.S, P3/Z, Z13.S, Z8.S  // 01100101-10001000-11101101-10110111
// CHECK: facgt   p7.s, p3/z, z13.s, z8.s // encoding: [0xb7,0xed,0x88,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10001000-11101101-10110111
facgt   p15.s, p7/z, z31.s, z31.s  // 01100101-10011111-11111111-11111111
// CHECK: facgt   p15.s, p7/z, z31.s, z31.s // encoding: [0xff,0xff,0x9f,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10011111-11111111-11111111
FACGT   P15.S, P7/Z, Z31.S, Z31.S  // 01100101-10011111-11111111-11111111
// CHECK: facgt   p15.s, p7/z, z31.s, z31.s // encoding: [0xff,0xff,0x9f,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10011111-11111111-11111111
facgt   p0.s, p0/z, z0.s, z0.s  // 01100101-10000000-11100000-00010000
// CHECK: facgt   p0.s, p0/z, z0.s, z0.s // encoding: [0x10,0xe0,0x80,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10000000-11100000-00010000
FACGT   P0.S, P0/Z, Z0.S, Z0.S  // 01100101-10000000-11100000-00010000
// CHECK: facgt   p0.s, p0/z, z0.s, z0.s // encoding: [0x10,0xe0,0x80,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10000000-11100000-00010000
facgt   p5.s, p5/z, z10.s, z21.s  // 01100101-10010101-11110101-01010101
// CHECK: facgt   p5.s, p5/z, z10.s, z21.s // encoding: [0x55,0xf5,0x95,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010101-11110101-01010101
FACGT   P5.S, P5/Z, Z10.S, Z21.S  // 01100101-10010101-11110101-01010101
// CHECK: facgt   p5.s, p5/z, z10.s, z21.s // encoding: [0x55,0xf5,0x95,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010101-11110101-01010101
