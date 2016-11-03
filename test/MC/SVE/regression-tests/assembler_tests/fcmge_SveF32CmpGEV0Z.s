// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fcmge   p5.s, p5/z, z10.s, #0.0  // 01100101-10010000-00110101-01000101
// CHECK: fcmge   p5.s, p5/z, z10.s, #0.0{{0*}} // encoding: [0x45,0x35,0x90,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010000-00110101-01000101
FCMGE   P5.S, P5/Z, Z10.S, #0.0  // 01100101-10010000-00110101-01000101
// CHECK: fcmge   p5.s, p5/z, z10.s, #0.0{{0*}} // encoding: [0x45,0x35,0x90,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010000-00110101-01000101
fcmge   p0.s, p0/z, z0.s, #0.0  // 01100101-10010000-00100000-00000000
// CHECK: fcmge   p0.s, p0/z, z0.s, #0.0{{0*}} // encoding: [0x00,0x20,0x90,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010000-00100000-00000000
FCMGE   P0.S, P0/Z, Z0.S, #0.0  // 01100101-10010000-00100000-00000000
// CHECK: fcmge   p0.s, p0/z, z0.s, #0.0{{0*}} // encoding: [0x00,0x20,0x90,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010000-00100000-00000000
fcmge   p15.s, p7/z, z31.s, #0.0  // 01100101-10010000-00111111-11101111
// CHECK: fcmge   p15.s, p7/z, z31.s, #0.0{{0*}} // encoding: [0xef,0x3f,0x90,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010000-00111111-11101111
FCMGE   P15.S, P7/Z, Z31.S, #0.0  // 01100101-10010000-00111111-11101111
// CHECK: fcmge   p15.s, p7/z, z31.s, #0.0{{0*}} // encoding: [0xef,0x3f,0x90,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010000-00111111-11101111
fcmge   p7.s, p3/z, z13.s, #0.0  // 01100101-10010000-00101101-10100111
// CHECK: fcmge   p7.s, p3/z, z13.s, #0.0{{0*}} // encoding: [0xa7,0x2d,0x90,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010000-00101101-10100111
FCMGE   P7.S, P3/Z, Z13.S, #0.0  // 01100101-10010000-00101101-10100111
// CHECK: fcmge   p7.s, p3/z, z13.s, #0.0{{0*}} // encoding: [0xa7,0x2d,0x90,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010000-00101101-10100111
