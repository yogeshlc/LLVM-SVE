// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fcmle   p7.d, p3/z, z13.d, #0.0  // 01100101-11010001-00101101-10110111
// CHECK: fcmle   p7.d, p3/z, z13.d, #0.0{{0*}} // encoding: [0xb7,0x2d,0xd1,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010001-00101101-10110111
FCMLE   P7.D, P3/Z, Z13.D, #0.0  // 01100101-11010001-00101101-10110111
// CHECK: fcmle   p7.d, p3/z, z13.d, #0.0{{0*}} // encoding: [0xb7,0x2d,0xd1,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010001-00101101-10110111
fcmle   p15.d, p7/z, z31.d, #0.0  // 01100101-11010001-00111111-11111111
// CHECK: fcmle   p15.d, p7/z, z31.d, #0.0{{0*}} // encoding: [0xff,0x3f,0xd1,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010001-00111111-11111111
FCMLE   P15.D, P7/Z, Z31.D, #0.0  // 01100101-11010001-00111111-11111111
// CHECK: fcmle   p15.d, p7/z, z31.d, #0.0{{0*}} // encoding: [0xff,0x3f,0xd1,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010001-00111111-11111111
fcmle   p5.d, p5/z, z10.d, #0.0  // 01100101-11010001-00110101-01010101
// CHECK: fcmle   p5.d, p5/z, z10.d, #0.0{{0*}} // encoding: [0x55,0x35,0xd1,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010001-00110101-01010101
FCMLE   P5.D, P5/Z, Z10.D, #0.0  // 01100101-11010001-00110101-01010101
// CHECK: fcmle   p5.d, p5/z, z10.d, #0.0{{0*}} // encoding: [0x55,0x35,0xd1,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010001-00110101-01010101
fcmle   p0.d, p0/z, z0.d, #0.0  // 01100101-11010001-00100000-00010000
// CHECK: fcmle   p0.d, p0/z, z0.d, #0.0{{0*}} // encoding: [0x10,0x20,0xd1,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010001-00100000-00010000
FCMLE   P0.D, P0/Z, Z0.D, #0.0  // 01100101-11010001-00100000-00010000
// CHECK: fcmle   p0.d, p0/z, z0.d, #0.0{{0*}} // encoding: [0x10,0x20,0xd1,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010001-00100000-00010000
