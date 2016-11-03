// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
sqdecd  x0, pow2  // 00000100-11110000-11111000-00000000
// CHECK: sqdecd  x0, pow2 // encoding: [0x00,0xf8,0xf0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11110000-11111000-00000000
SQDECD  X0, POW2  // 00000100-11110000-11111000-00000000
// CHECK: sqdecd  x0, pow2 // encoding: [0x00,0xf8,0xf0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11110000-11111000-00000000
sqdecd  x21, vl32, mul #6  // 00000100-11110101-11111001-01010101
// CHECK: sqdecd  x21, vl32, mul #6 // encoding: [0x55,0xf9,0xf5,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11110101-11111001-01010101
SQDECD  X21, VL32, MUL #6  // 00000100-11110101-11111001-01010101
// CHECK: sqdecd  x21, vl32, mul #6 // encoding: [0x55,0xf9,0xf5,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11110101-11111001-01010101
sqdecd  xzr, all, mul #16  // 00000100-11111111-11111011-11111111
// CHECK: sqdecd  xzr, all, mul #16 // encoding: [0xff,0xfb,0xff,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11111111-11111011-11111111
SQDECD  XZR, ALL, MUL #16  // 00000100-11111111-11111011-11111111
// CHECK: sqdecd  xzr, all, mul #16 // encoding: [0xff,0xfb,0xff,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11111111-11111011-11111111
sqdecd  x23, vl256, mul #9  // 00000100-11111000-11111001-10110111
// CHECK: sqdecd  x23, vl256, mul #9 // encoding: [0xb7,0xf9,0xf8,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11111000-11111001-10110111
SQDECD  X23, VL256, MUL #9  // 00000100-11111000-11111001-10110111
// CHECK: sqdecd  x23, vl256, mul #9 // encoding: [0xb7,0xf9,0xf8,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11111000-11111001-10110111
