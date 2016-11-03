// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
incw    z0.s, pow2  // 00000100-10110000-11000000-00000000
// CHECK: incw    z0.s, pow2 // encoding: [0x00,0xc0,0xb0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10110000-11000000-00000000
INCW    Z0.S, POW2  // 00000100-10110000-11000000-00000000
// CHECK: incw    z0.s, pow2 // encoding: [0x00,0xc0,0xb0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10110000-11000000-00000000
incw    z21.s, vl32, mul #6  // 00000100-10110101-11000001-01010101
// CHECK: incw    z21.s, vl32, mul #6 // encoding: [0x55,0xc1,0xb5,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10110101-11000001-01010101
INCW    Z21.S, VL32, MUL #6  // 00000100-10110101-11000001-01010101
// CHECK: incw    z21.s, vl32, mul #6 // encoding: [0x55,0xc1,0xb5,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10110101-11000001-01010101
incw    z31.s, all, mul #16  // 00000100-10111111-11000011-11111111
// CHECK: incw    z31.s, all, mul #16 // encoding: [0xff,0xc3,0xbf,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10111111-11000011-11111111
INCW    Z31.S, ALL, MUL #16  // 00000100-10111111-11000011-11111111
// CHECK: incw    z31.s, all, mul #16 // encoding: [0xff,0xc3,0xbf,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10111111-11000011-11111111
incw    z23.s, vl256, mul #9  // 00000100-10111000-11000001-10110111
// CHECK: incw    z23.s, vl256, mul #9 // encoding: [0xb7,0xc1,0xb8,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10111000-11000001-10110111
INCW    Z23.S, VL256, MUL #9  // 00000100-10111000-11000001-10110111
// CHECK: incw    z23.s, vl256, mul #9 // encoding: [0xb7,0xc1,0xb8,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10111000-11000001-10110111
