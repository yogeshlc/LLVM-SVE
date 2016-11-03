// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fcmne   p15.d, p7/z, z31.d, z31.d  // 01100101-11011111-01111111-11111111
// CHECK: fcmne   p15.d, p7/z, z31.d, z31.d // encoding: [0xff,0x7f,0xdf,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11011111-01111111-11111111
FCMNE   P15.D, P7/Z, Z31.D, Z31.D  // 01100101-11011111-01111111-11111111
// CHECK: fcmne   p15.d, p7/z, z31.d, z31.d // encoding: [0xff,0x7f,0xdf,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11011111-01111111-11111111
fcmne   p5.d, p5/z, z10.d, z21.d  // 01100101-11010101-01110101-01010101
// CHECK: fcmne   p5.d, p5/z, z10.d, z21.d // encoding: [0x55,0x75,0xd5,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010101-01110101-01010101
FCMNE   P5.D, P5/Z, Z10.D, Z21.D  // 01100101-11010101-01110101-01010101
// CHECK: fcmne   p5.d, p5/z, z10.d, z21.d // encoding: [0x55,0x75,0xd5,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010101-01110101-01010101
fcmne   p0.d, p0/z, z0.d, z0.d  // 01100101-11000000-01100000-00010000
// CHECK: fcmne   p0.d, p0/z, z0.d, z0.d // encoding: [0x10,0x60,0xc0,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11000000-01100000-00010000
FCMNE   P0.D, P0/Z, Z0.D, Z0.D  // 01100101-11000000-01100000-00010000
// CHECK: fcmne   p0.d, p0/z, z0.d, z0.d // encoding: [0x10,0x60,0xc0,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11000000-01100000-00010000
fcmne   p7.d, p3/z, z13.d, z8.d  // 01100101-11001000-01101101-10110111
// CHECK: fcmne   p7.d, p3/z, z13.d, z8.d // encoding: [0xb7,0x6d,0xc8,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11001000-01101101-10110111
FCMNE   P7.D, P3/Z, Z13.D, Z8.D  // 01100101-11001000-01101101-10110111
// CHECK: fcmne   p7.d, p3/z, z13.d, z8.d // encoding: [0xb7,0x6d,0xc8,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11001000-01101101-10110111
