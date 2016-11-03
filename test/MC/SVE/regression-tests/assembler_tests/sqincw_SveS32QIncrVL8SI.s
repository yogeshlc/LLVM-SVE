// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
sqincw  x23, vl256, mul #9  // 00000100-10111000-11110001-10110111
// CHECK: sqincw  x23, vl256, mul #9 // encoding: [0xb7,0xf1,0xb8,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10111000-11110001-10110111
SQINCW  X23, VL256, MUL #9  // 00000100-10111000-11110001-10110111
// CHECK: sqincw  x23, vl256, mul #9 // encoding: [0xb7,0xf1,0xb8,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10111000-11110001-10110111
sqincw  x21, vl32, mul #6  // 00000100-10110101-11110001-01010101
// CHECK: sqincw  x21, vl32, mul #6 // encoding: [0x55,0xf1,0xb5,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10110101-11110001-01010101
SQINCW  X21, VL32, MUL #6  // 00000100-10110101-11110001-01010101
// CHECK: sqincw  x21, vl32, mul #6 // encoding: [0x55,0xf1,0xb5,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10110101-11110001-01010101
sqincw  xzr, all, mul #16  // 00000100-10111111-11110011-11111111
// CHECK: sqincw  xzr, all, mul #16 // encoding: [0xff,0xf3,0xbf,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10111111-11110011-11111111
SQINCW  XZR, ALL, MUL #16  // 00000100-10111111-11110011-11111111
// CHECK: sqincw  xzr, all, mul #16 // encoding: [0xff,0xf3,0xbf,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10111111-11110011-11111111
sqincw  x0, pow2  // 00000100-10110000-11110000-00000000
// CHECK: sqincw  x0, pow2 // encoding: [0x00,0xf0,0xb0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10110000-11110000-00000000
SQINCW  X0, POW2  // 00000100-10110000-11110000-00000000
// CHECK: sqincw  x0, pow2 // encoding: [0x00,0xf0,0xb0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10110000-11110000-00000000
