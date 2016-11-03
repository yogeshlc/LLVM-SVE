// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
smaxv   s23, p3, z13.s  // 00000100-10001000-00101101-10110111
// CHECK: smaxv   s23, p3, z13.s // encoding: [0xb7,0x2d,0x88,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10001000-00101101-10110111
SMAXV   S23, P3, Z13.S  // 00000100-10001000-00101101-10110111
// CHECK: smaxv   s23, p3, z13.s // encoding: [0xb7,0x2d,0x88,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10001000-00101101-10110111
smaxv   s31, p7, z31.s  // 00000100-10001000-00111111-11111111
// CHECK: smaxv   s31, p7, z31.s // encoding: [0xff,0x3f,0x88,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10001000-00111111-11111111
SMAXV   S31, P7, Z31.S  // 00000100-10001000-00111111-11111111
// CHECK: smaxv   s31, p7, z31.s // encoding: [0xff,0x3f,0x88,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10001000-00111111-11111111
smaxv   s21, p5, z10.s  // 00000100-10001000-00110101-01010101
// CHECK: smaxv   s21, p5, z10.s // encoding: [0x55,0x35,0x88,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10001000-00110101-01010101
SMAXV   S21, P5, Z10.S  // 00000100-10001000-00110101-01010101
// CHECK: smaxv   s21, p5, z10.s // encoding: [0x55,0x35,0x88,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10001000-00110101-01010101
smaxv   s0, p0, z0.s  // 00000100-10001000-00100000-00000000
// CHECK: smaxv   s0, p0, z0.s // encoding: [0x00,0x20,0x88,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10001000-00100000-00000000
SMAXV   S0, P0, Z0.S  // 00000100-10001000-00100000-00000000
// CHECK: smaxv   s0, p0, z0.s // encoding: [0x00,0x20,0x88,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10001000-00100000-00000000
