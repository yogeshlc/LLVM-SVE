// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
facge   p7.s, p3/z, z13.s, z8.s  // 01100101-10001000-11001101-10110111
// CHECK: facge   p7.s, p3/z, z13.s, z8.s // encoding: [0xb7,0xcd,0x88,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10001000-11001101-10110111
FACGE   P7.S, P3/Z, Z13.S, Z8.S  // 01100101-10001000-11001101-10110111
// CHECK: facge   p7.s, p3/z, z13.s, z8.s // encoding: [0xb7,0xcd,0x88,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10001000-11001101-10110111
facge   p0.s, p0/z, z0.s, z0.s  // 01100101-10000000-11000000-00010000
// CHECK: facge   p0.s, p0/z, z0.s, z0.s // encoding: [0x10,0xc0,0x80,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10000000-11000000-00010000
FACGE   P0.S, P0/Z, Z0.S, Z0.S  // 01100101-10000000-11000000-00010000
// CHECK: facge   p0.s, p0/z, z0.s, z0.s // encoding: [0x10,0xc0,0x80,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10000000-11000000-00010000
facge   p5.s, p5/z, z10.s, z21.s  // 01100101-10010101-11010101-01010101
// CHECK: facge   p5.s, p5/z, z10.s, z21.s // encoding: [0x55,0xd5,0x95,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010101-11010101-01010101
FACGE   P5.S, P5/Z, Z10.S, Z21.S  // 01100101-10010101-11010101-01010101
// CHECK: facge   p5.s, p5/z, z10.s, z21.s // encoding: [0x55,0xd5,0x95,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010101-11010101-01010101
facge   p15.s, p7/z, z31.s, z31.s  // 01100101-10011111-11011111-11111111
// CHECK: facge   p15.s, p7/z, z31.s, z31.s // encoding: [0xff,0xdf,0x9f,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10011111-11011111-11111111
FACGE   P15.S, P7/Z, Z31.S, Z31.S  // 01100101-10011111-11011111-11111111
// CHECK: facge   p15.s, p7/z, z31.s, z31.s // encoding: [0xff,0xdf,0x9f,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10011111-11011111-11111111
