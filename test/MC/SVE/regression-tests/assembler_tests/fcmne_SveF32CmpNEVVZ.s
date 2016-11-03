// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fcmne   p0.s, p0/z, z0.s, z0.s  // 01100101-10000000-01100000-00010000
// CHECK: fcmne   p0.s, p0/z, z0.s, z0.s // encoding: [0x10,0x60,0x80,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10000000-01100000-00010000
FCMNE   P0.S, P0/Z, Z0.S, Z0.S  // 01100101-10000000-01100000-00010000
// CHECK: fcmne   p0.s, p0/z, z0.s, z0.s // encoding: [0x10,0x60,0x80,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10000000-01100000-00010000
fcmne   p7.s, p3/z, z13.s, z8.s  // 01100101-10001000-01101101-10110111
// CHECK: fcmne   p7.s, p3/z, z13.s, z8.s // encoding: [0xb7,0x6d,0x88,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10001000-01101101-10110111
FCMNE   P7.S, P3/Z, Z13.S, Z8.S  // 01100101-10001000-01101101-10110111
// CHECK: fcmne   p7.s, p3/z, z13.s, z8.s // encoding: [0xb7,0x6d,0x88,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10001000-01101101-10110111
fcmne   p15.s, p7/z, z31.s, z31.s  // 01100101-10011111-01111111-11111111
// CHECK: fcmne   p15.s, p7/z, z31.s, z31.s // encoding: [0xff,0x7f,0x9f,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10011111-01111111-11111111
FCMNE   P15.S, P7/Z, Z31.S, Z31.S  // 01100101-10011111-01111111-11111111
// CHECK: fcmne   p15.s, p7/z, z31.s, z31.s // encoding: [0xff,0x7f,0x9f,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10011111-01111111-11111111
fcmne   p5.s, p5/z, z10.s, z21.s  // 01100101-10010101-01110101-01010101
// CHECK: fcmne   p5.s, p5/z, z10.s, z21.s // encoding: [0x55,0x75,0x95,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010101-01110101-01010101
FCMNE   P5.S, P5/Z, Z10.S, Z21.S  // 01100101-10010101-01110101-01010101
// CHECK: fcmne   p5.s, p5/z, z10.s, z21.s // encoding: [0x55,0x75,0x95,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010101-01110101-01010101
