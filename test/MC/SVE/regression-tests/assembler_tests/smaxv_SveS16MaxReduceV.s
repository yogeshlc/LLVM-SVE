// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
smaxv   h21, p5, z10.h  // 00000100-01001000-00110101-01010101
// CHECK: smaxv   h21, p5, z10.h // encoding: [0x55,0x35,0x48,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01001000-00110101-01010101
SMAXV   H21, P5, Z10.H  // 00000100-01001000-00110101-01010101
// CHECK: smaxv   h21, p5, z10.h // encoding: [0x55,0x35,0x48,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01001000-00110101-01010101
smaxv   h0, p0, z0.h  // 00000100-01001000-00100000-00000000
// CHECK: smaxv   h0, p0, z0.h // encoding: [0x00,0x20,0x48,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01001000-00100000-00000000
SMAXV   H0, P0, Z0.H  // 00000100-01001000-00100000-00000000
// CHECK: smaxv   h0, p0, z0.h // encoding: [0x00,0x20,0x48,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01001000-00100000-00000000
smaxv   h23, p3, z13.h  // 00000100-01001000-00101101-10110111
// CHECK: smaxv   h23, p3, z13.h // encoding: [0xb7,0x2d,0x48,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01001000-00101101-10110111
SMAXV   H23, P3, Z13.H  // 00000100-01001000-00101101-10110111
// CHECK: smaxv   h23, p3, z13.h // encoding: [0xb7,0x2d,0x48,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01001000-00101101-10110111
smaxv   h31, p7, z31.h  // 00000100-01001000-00111111-11111111
// CHECK: smaxv   h31, p7, z31.h // encoding: [0xff,0x3f,0x48,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01001000-00111111-11111111
SMAXV   H31, P7, Z31.H  // 00000100-01001000-00111111-11111111
// CHECK: smaxv   h31, p7, z31.h // encoding: [0xff,0x3f,0x48,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01001000-00111111-11111111
