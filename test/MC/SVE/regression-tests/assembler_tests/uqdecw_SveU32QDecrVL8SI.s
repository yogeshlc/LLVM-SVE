// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
uqdecw  x23, vl256, mul #9  // 00000100-10111000-11111101-10110111
// CHECK: uqdecw  x23, vl256, mul #9 // encoding: [0xb7,0xfd,0xb8,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10111000-11111101-10110111
UQDECW  X23, VL256, MUL #9  // 00000100-10111000-11111101-10110111
// CHECK: uqdecw  x23, vl256, mul #9 // encoding: [0xb7,0xfd,0xb8,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10111000-11111101-10110111
uqdecw  x21, vl32, mul #6  // 00000100-10110101-11111101-01010101
// CHECK: uqdecw  x21, vl32, mul #6 // encoding: [0x55,0xfd,0xb5,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10110101-11111101-01010101
UQDECW  X21, VL32, MUL #6  // 00000100-10110101-11111101-01010101
// CHECK: uqdecw  x21, vl32, mul #6 // encoding: [0x55,0xfd,0xb5,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10110101-11111101-01010101
uqdecw  x0, pow2  // 00000100-10110000-11111100-00000000
// CHECK: uqdecw  x0, pow2 // encoding: [0x00,0xfc,0xb0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10110000-11111100-00000000
UQDECW  X0, POW2  // 00000100-10110000-11111100-00000000
// CHECK: uqdecw  x0, pow2 // encoding: [0x00,0xfc,0xb0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10110000-11111100-00000000
uqdecw  xzr, all, mul #16  // 00000100-10111111-11111111-11111111
// CHECK: uqdecw  xzr, all, mul #16 // encoding: [0xff,0xff,0xbf,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10111111-11111111-11111111
UQDECW  XZR, ALL, MUL #16  // 00000100-10111111-11111111-11111111
// CHECK: uqdecw  xzr, all, mul #16 // encoding: [0xff,0xff,0xbf,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10111111-11111111-11111111
