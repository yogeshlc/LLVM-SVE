// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
sqincw  z21.s, vl32, mul #6  // 00000100-10100101-11000001-01010101
// CHECK: sqincw  z21.s, vl32, mul #6 // encoding: [0x55,0xc1,0xa5,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10100101-11000001-01010101
SQINCW  Z21.S, VL32, MUL #6  // 00000100-10100101-11000001-01010101
// CHECK: sqincw  z21.s, vl32, mul #6 // encoding: [0x55,0xc1,0xa5,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10100101-11000001-01010101
sqincw  z0.s, pow2  // 00000100-10100000-11000000-00000000
// CHECK: sqincw  z0.s, pow2 // encoding: [0x00,0xc0,0xa0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10100000-11000000-00000000
SQINCW  Z0.S, POW2  // 00000100-10100000-11000000-00000000
// CHECK: sqincw  z0.s, pow2 // encoding: [0x00,0xc0,0xa0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10100000-11000000-00000000
sqincw  z31.s, all, mul #16  // 00000100-10101111-11000011-11111111
// CHECK: sqincw  z31.s, all, mul #16 // encoding: [0xff,0xc3,0xaf,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10101111-11000011-11111111
SQINCW  Z31.S, ALL, MUL #16  // 00000100-10101111-11000011-11111111
// CHECK: sqincw  z31.s, all, mul #16 // encoding: [0xff,0xc3,0xaf,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10101111-11000011-11111111
sqincw  z23.s, vl256, mul #9  // 00000100-10101000-11000001-10110111
// CHECK: sqincw  z23.s, vl256, mul #9 // encoding: [0xb7,0xc1,0xa8,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10101000-11000001-10110111
SQINCW  Z23.S, VL256, MUL #9  // 00000100-10101000-11000001-10110111
// CHECK: sqincw  z23.s, vl256, mul #9 // encoding: [0xb7,0xc1,0xa8,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10101000-11000001-10110111
