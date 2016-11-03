// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fcmgt   p0.d, p0/z, z0.d, #0.0  // 01100101-11010000-00100000-00010000
// CHECK: fcmgt   p0.d, p0/z, z0.d, #0.0{{0*}} // encoding: [0x10,0x20,0xd0,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010000-00100000-00010000
FCMGT   P0.D, P0/Z, Z0.D, #0.0  // 01100101-11010000-00100000-00010000
// CHECK: fcmgt   p0.d, p0/z, z0.d, #0.0{{0*}} // encoding: [0x10,0x20,0xd0,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010000-00100000-00010000
fcmgt   p7.d, p3/z, z13.d, #0.0  // 01100101-11010000-00101101-10110111
// CHECK: fcmgt   p7.d, p3/z, z13.d, #0.0{{0*}} // encoding: [0xb7,0x2d,0xd0,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010000-00101101-10110111
FCMGT   P7.D, P3/Z, Z13.D, #0.0  // 01100101-11010000-00101101-10110111
// CHECK: fcmgt   p7.d, p3/z, z13.d, #0.0{{0*}} // encoding: [0xb7,0x2d,0xd0,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010000-00101101-10110111
fcmgt   p15.d, p7/z, z31.d, #0.0  // 01100101-11010000-00111111-11111111
// CHECK: fcmgt   p15.d, p7/z, z31.d, #0.0{{0*}} // encoding: [0xff,0x3f,0xd0,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010000-00111111-11111111
FCMGT   P15.D, P7/Z, Z31.D, #0.0  // 01100101-11010000-00111111-11111111
// CHECK: fcmgt   p15.d, p7/z, z31.d, #0.0{{0*}} // encoding: [0xff,0x3f,0xd0,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010000-00111111-11111111
fcmgt   p5.d, p5/z, z10.d, #0.0  // 01100101-11010000-00110101-01010101
// CHECK: fcmgt   p5.d, p5/z, z10.d, #0.0{{0*}} // encoding: [0x55,0x35,0xd0,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010000-00110101-01010101
FCMGT   P5.D, P5/Z, Z10.D, #0.0  // 01100101-11010000-00110101-01010101
// CHECK: fcmgt   p5.d, p5/z, z10.d, #0.0{{0*}} // encoding: [0x55,0x35,0xd0,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010000-00110101-01010101
