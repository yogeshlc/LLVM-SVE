// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fcmle   p15.s, p7/z, z31.s, #0.0  // 01100101-10010001-00111111-11111111
// CHECK: fcmle   p15.s, p7/z, z31.s, #0.0{{0*}} // encoding: [0xff,0x3f,0x91,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010001-00111111-11111111
FCMLE   P15.S, P7/Z, Z31.S, #0.0  // 01100101-10010001-00111111-11111111
// CHECK: fcmle   p15.s, p7/z, z31.s, #0.0{{0*}} // encoding: [0xff,0x3f,0x91,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010001-00111111-11111111
fcmle   p5.s, p5/z, z10.s, #0.0  // 01100101-10010001-00110101-01010101
// CHECK: fcmle   p5.s, p5/z, z10.s, #0.0{{0*}} // encoding: [0x55,0x35,0x91,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010001-00110101-01010101
FCMLE   P5.S, P5/Z, Z10.S, #0.0  // 01100101-10010001-00110101-01010101
// CHECK: fcmle   p5.s, p5/z, z10.s, #0.0{{0*}} // encoding: [0x55,0x35,0x91,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010001-00110101-01010101
fcmle   p0.s, p0/z, z0.s, #0.0  // 01100101-10010001-00100000-00010000
// CHECK: fcmle   p0.s, p0/z, z0.s, #0.0{{0*}} // encoding: [0x10,0x20,0x91,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010001-00100000-00010000
FCMLE   P0.S, P0/Z, Z0.S, #0.0  // 01100101-10010001-00100000-00010000
// CHECK: fcmle   p0.s, p0/z, z0.s, #0.0{{0*}} // encoding: [0x10,0x20,0x91,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010001-00100000-00010000
fcmle   p7.s, p3/z, z13.s, #0.0  // 01100101-10010001-00101101-10110111
// CHECK: fcmle   p7.s, p3/z, z13.s, #0.0{{0*}} // encoding: [0xb7,0x2d,0x91,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010001-00101101-10110111
FCMLE   P7.S, P3/Z, Z13.S, #0.0  // 01100101-10010001-00101101-10110111
// CHECK: fcmle   p7.s, p3/z, z13.s, #0.0{{0*}} // encoding: [0xb7,0x2d,0x91,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010001-00101101-10110111
