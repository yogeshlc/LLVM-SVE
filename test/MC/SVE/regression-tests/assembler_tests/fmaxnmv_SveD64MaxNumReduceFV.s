// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fmaxnmv d31, p7, z31.d  // 01100101-11000100-00111111-11111111
// CHECK: fmaxnmv d31, p7, z31.d // encoding: [0xff,0x3f,0xc4,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11000100-00111111-11111111
FMAXNMV D31, P7, Z31.D  // 01100101-11000100-00111111-11111111
// CHECK: fmaxnmv d31, p7, z31.d // encoding: [0xff,0x3f,0xc4,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11000100-00111111-11111111
fmaxnmv d0, p0, z0.d  // 01100101-11000100-00100000-00000000
// CHECK: fmaxnmv d0, p0, z0.d // encoding: [0x00,0x20,0xc4,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11000100-00100000-00000000
FMAXNMV D0, P0, Z0.D  // 01100101-11000100-00100000-00000000
// CHECK: fmaxnmv d0, p0, z0.d // encoding: [0x00,0x20,0xc4,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11000100-00100000-00000000
fmaxnmv d23, p3, z13.d  // 01100101-11000100-00101101-10110111
// CHECK: fmaxnmv d23, p3, z13.d // encoding: [0xb7,0x2d,0xc4,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11000100-00101101-10110111
FMAXNMV D23, P3, Z13.D  // 01100101-11000100-00101101-10110111
// CHECK: fmaxnmv d23, p3, z13.d // encoding: [0xb7,0x2d,0xc4,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11000100-00101101-10110111
fmaxnmv d21, p5, z10.d  // 01100101-11000100-00110101-01010101
// CHECK: fmaxnmv d21, p5, z10.d // encoding: [0x55,0x35,0xc4,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11000100-00110101-01010101
FMAXNMV D21, P5, Z10.D  // 01100101-11000100-00110101-01010101
// CHECK: fmaxnmv d21, p5, z10.d // encoding: [0x55,0x35,0xc4,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11000100-00110101-01010101
