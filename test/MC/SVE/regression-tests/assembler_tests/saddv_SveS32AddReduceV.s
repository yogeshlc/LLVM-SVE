// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
saddv   d21, p5, z10.s  // 00000100-10000000-00110101-01010101
// CHECK: saddv   d21, p5, z10.s // encoding: [0x55,0x35,0x80,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10000000-00110101-01010101
SADDV   D21, P5, Z10.S  // 00000100-10000000-00110101-01010101
// CHECK: saddv   d21, p5, z10.s // encoding: [0x55,0x35,0x80,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10000000-00110101-01010101
saddv   d23, p3, z13.s  // 00000100-10000000-00101101-10110111
// CHECK: saddv   d23, p3, z13.s // encoding: [0xb7,0x2d,0x80,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10000000-00101101-10110111
SADDV   D23, P3, Z13.S  // 00000100-10000000-00101101-10110111
// CHECK: saddv   d23, p3, z13.s // encoding: [0xb7,0x2d,0x80,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10000000-00101101-10110111
saddv   d0, p0, z0.s  // 00000100-10000000-00100000-00000000
// CHECK: saddv   d0, p0, z0.s // encoding: [0x00,0x20,0x80,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10000000-00100000-00000000
SADDV   D0, P0, Z0.S  // 00000100-10000000-00100000-00000000
// CHECK: saddv   d0, p0, z0.s // encoding: [0x00,0x20,0x80,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10000000-00100000-00000000
saddv   d31, p7, z31.s  // 00000100-10000000-00111111-11111111
// CHECK: saddv   d31, p7, z31.s // encoding: [0xff,0x3f,0x80,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10000000-00111111-11111111
SADDV   D31, P7, Z31.S  // 00000100-10000000-00111111-11111111
// CHECK: saddv   d31, p7, z31.s // encoding: [0xff,0x3f,0x80,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10000000-00111111-11111111
