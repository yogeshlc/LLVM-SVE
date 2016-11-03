// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
asrd    z0.s, p0/m, z0.s, #32  // 00000100-01000100-10000000-00000000
// CHECK: asrd    z0.s, p0/m, z0.s, #32 // encoding: [0x00,0x80,0x44,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01000100-10000000-00000000
ASRD    Z0.S, P0/M, Z0.S, #32  // 00000100-01000100-10000000-00000000
// CHECK: asrd    z0.s, p0/m, z0.s, #32 // encoding: [0x00,0x80,0x44,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01000100-10000000-00000000
asrd    z31.s, p7/m, z31.s, #1  // 00000100-01000100-10011111-11111111
// CHECK: asrd    z31.s, p7/m, z31.s, #1 // encoding: [0xff,0x9f,0x44,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01000100-10011111-11111111
ASRD    Z31.S, P7/M, Z31.S, #1  // 00000100-01000100-10011111-11111111
// CHECK: asrd    z31.s, p7/m, z31.s, #1 // encoding: [0xff,0x9f,0x44,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01000100-10011111-11111111
asrd    z21.s, p5/m, z21.s, #22  // 00000100-01000100-10010101-01010101
// CHECK: asrd    z21.s, p5/m, z21.s, #22 // encoding: [0x55,0x95,0x44,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01000100-10010101-01010101
ASRD    Z21.S, P5/M, Z21.S, #22  // 00000100-01000100-10010101-01010101
// CHECK: asrd    z21.s, p5/m, z21.s, #22 // encoding: [0x55,0x95,0x44,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01000100-10010101-01010101
asrd    z23.s, p3/m, z23.s, #19  // 00000100-01000100-10001101-10110111
// CHECK: asrd    z23.s, p3/m, z23.s, #19 // encoding: [0xb7,0x8d,0x44,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01000100-10001101-10110111
ASRD    Z23.S, P3/M, Z23.S, #19  // 00000100-01000100-10001101-10110111
// CHECK: asrd    z23.s, p3/m, z23.s, #19 // encoding: [0xb7,0x8d,0x44,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01000100-10001101-10110111
