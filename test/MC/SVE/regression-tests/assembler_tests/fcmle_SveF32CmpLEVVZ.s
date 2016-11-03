// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fcmle   p7.s, p3/z, z8.s, z13.s  // 01100101-10001000-01001101-10100111
// CHECK: fcmge   p7.s, p3/z, z13.s, z8.s // encoding: [0xa7,0x4d,0x88,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10001000-01001101-10100111
FCMLE   P7.S, P3/Z, Z8.S, Z13.S  // 01100101-10001000-01001101-10100111
// CHECK: fcmge   p7.s, p3/z, z13.s, z8.s // encoding: [0xa7,0x4d,0x88,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10001000-01001101-10100111
fcmle   p15.s, p7/z, z31.s, z31.s  // 01100101-10011111-01011111-11101111
// CHECK: fcmge   p15.s, p7/z, z31.s, z31.s // encoding: [0xef,0x5f,0x9f,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10011111-01011111-11101111
FCMLE   P15.S, P7/Z, Z31.S, Z31.S  // 01100101-10011111-01011111-11101111
// CHECK: fcmge   p15.s, p7/z, z31.s, z31.s // encoding: [0xef,0x5f,0x9f,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10011111-01011111-11101111
fcmle   p5.s, p5/z, z21.s, z10.s  // 01100101-10010101-01010101-01000101
// CHECK: fcmge   p5.s, p5/z, z10.s, z21.s // encoding: [0x45,0x55,0x95,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010101-01010101-01000101
FCMLE   P5.S, P5/Z, Z21.S, Z10.S  // 01100101-10010101-01010101-01000101
// CHECK: fcmge   p5.s, p5/z, z10.s, z21.s // encoding: [0x45,0x55,0x95,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010101-01010101-01000101
fcmle   p0.s, p0/z, z0.s, z0.s  // 01100101-10000000-01000000-00000000
// CHECK: fcmge   p0.s, p0/z, z0.s, z0.s // encoding: [0x00,0x40,0x80,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10000000-01000000-00000000
FCMLE   P0.S, P0/Z, Z0.S, Z0.S  // 01100101-10000000-01000000-00000000
// CHECK: fcmge   p0.s, p0/z, z0.s, z0.s // encoding: [0x00,0x40,0x80,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10000000-01000000-00000000
