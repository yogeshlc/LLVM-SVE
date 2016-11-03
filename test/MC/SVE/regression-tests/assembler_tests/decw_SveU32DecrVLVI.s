// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
decw    z31.s, all, mul #16  // 00000100-10111111-11000111-11111111
// CHECK: decw    z31.s, all, mul #16 // encoding: [0xff,0xc7,0xbf,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10111111-11000111-11111111
DECW    Z31.S, ALL, MUL #16  // 00000100-10111111-11000111-11111111
// CHECK: decw    z31.s, all, mul #16 // encoding: [0xff,0xc7,0xbf,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10111111-11000111-11111111
decw    z0.s, pow2  // 00000100-10110000-11000100-00000000
// CHECK: decw    z0.s, pow2 // encoding: [0x00,0xc4,0xb0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10110000-11000100-00000000
DECW    Z0.S, POW2  // 00000100-10110000-11000100-00000000
// CHECK: decw    z0.s, pow2 // encoding: [0x00,0xc4,0xb0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10110000-11000100-00000000
decw    z21.s, vl32, mul #6  // 00000100-10110101-11000101-01010101
// CHECK: decw    z21.s, vl32, mul #6 // encoding: [0x55,0xc5,0xb5,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10110101-11000101-01010101
DECW    Z21.S, VL32, MUL #6  // 00000100-10110101-11000101-01010101
// CHECK: decw    z21.s, vl32, mul #6 // encoding: [0x55,0xc5,0xb5,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10110101-11000101-01010101
decw    z23.s, vl256, mul #9  // 00000100-10111000-11000101-10110111
// CHECK: decw    z23.s, vl256, mul #9 // encoding: [0xb7,0xc5,0xb8,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10111000-11000101-10110111
DECW    Z23.S, VL256, MUL #9  // 00000100-10111000-11000101-10110111
// CHECK: decw    z23.s, vl256, mul #9 // encoding: [0xb7,0xc5,0xb8,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10111000-11000101-10110111
