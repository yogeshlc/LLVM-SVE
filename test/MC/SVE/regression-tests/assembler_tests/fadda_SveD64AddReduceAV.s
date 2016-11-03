// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fadda   d23, p3, d23, z13.d  // 01100101-11011000-00101101-10110111
// CHECK: fadda   d23, p3, d23, z13.d // encoding: [0xb7,0x2d,0xd8,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11011000-00101101-10110111
FADDA   D23, P3, D23, Z13.D  // 01100101-11011000-00101101-10110111
// CHECK: fadda   d23, p3, d23, z13.d // encoding: [0xb7,0x2d,0xd8,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11011000-00101101-10110111
fadda   d0, p0, d0, z0.d  // 01100101-11011000-00100000-00000000
// CHECK: fadda   d0, p0, d0, z0.d // encoding: [0x00,0x20,0xd8,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11011000-00100000-00000000
FADDA   D0, P0, D0, Z0.D  // 01100101-11011000-00100000-00000000
// CHECK: fadda   d0, p0, d0, z0.d // encoding: [0x00,0x20,0xd8,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11011000-00100000-00000000
fadda   d21, p5, d21, z10.d  // 01100101-11011000-00110101-01010101
// CHECK: fadda   d21, p5, d21, z10.d // encoding: [0x55,0x35,0xd8,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11011000-00110101-01010101
FADDA   D21, P5, D21, Z10.D  // 01100101-11011000-00110101-01010101
// CHECK: fadda   d21, p5, d21, z10.d // encoding: [0x55,0x35,0xd8,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11011000-00110101-01010101
fadda   d31, p7, d31, z31.d  // 01100101-11011000-00111111-11111111
// CHECK: fadda   d31, p7, d31, z31.d // encoding: [0xff,0x3f,0xd8,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11011000-00111111-11111111
FADDA   D31, P7, D31, Z31.D  // 01100101-11011000-00111111-11111111
// CHECK: fadda   d31, p7, d31, z31.d // encoding: [0xff,0x3f,0xd8,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11011000-00111111-11111111
