// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
eorv    d23, p3, z13.d  // 00000100-11011001-00101101-10110111
// CHECK: eorv    d23, p3, z13.d // encoding: [0xb7,0x2d,0xd9,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11011001-00101101-10110111
EORV    D23, P3, Z13.D  // 00000100-11011001-00101101-10110111
// CHECK: eorv    d23, p3, z13.d // encoding: [0xb7,0x2d,0xd9,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11011001-00101101-10110111
eorv    d21, p5, z10.d  // 00000100-11011001-00110101-01010101
// CHECK: eorv    d21, p5, z10.d // encoding: [0x55,0x35,0xd9,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11011001-00110101-01010101
EORV    D21, P5, Z10.D  // 00000100-11011001-00110101-01010101
// CHECK: eorv    d21, p5, z10.d // encoding: [0x55,0x35,0xd9,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11011001-00110101-01010101
eorv    d31, p7, z31.d  // 00000100-11011001-00111111-11111111
// CHECK: eorv    d31, p7, z31.d // encoding: [0xff,0x3f,0xd9,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11011001-00111111-11111111
EORV    D31, P7, Z31.D  // 00000100-11011001-00111111-11111111
// CHECK: eorv    d31, p7, z31.d // encoding: [0xff,0x3f,0xd9,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11011001-00111111-11111111
eorv    d0, p0, z0.d  // 00000100-11011001-00100000-00000000
// CHECK: eorv    d0, p0, z0.d // encoding: [0x00,0x20,0xd9,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11011001-00100000-00000000
EORV    D0, P0, Z0.D  // 00000100-11011001-00100000-00000000
// CHECK: eorv    d0, p0, z0.d // encoding: [0x00,0x20,0xd9,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11011001-00100000-00000000
