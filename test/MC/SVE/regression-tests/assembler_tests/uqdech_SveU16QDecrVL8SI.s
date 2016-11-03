// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
uqdech  xzr, all, mul #16  // 00000100-01111111-11111111-11111111
// CHECK: uqdech  xzr, all, mul #16 // encoding: [0xff,0xff,0x7f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01111111-11111111-11111111
UQDECH  XZR, ALL, MUL #16  // 00000100-01111111-11111111-11111111
// CHECK: uqdech  xzr, all, mul #16 // encoding: [0xff,0xff,0x7f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01111111-11111111-11111111
uqdech  x21, vl32, mul #6  // 00000100-01110101-11111101-01010101
// CHECK: uqdech  x21, vl32, mul #6 // encoding: [0x55,0xfd,0x75,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01110101-11111101-01010101
UQDECH  X21, VL32, MUL #6  // 00000100-01110101-11111101-01010101
// CHECK: uqdech  x21, vl32, mul #6 // encoding: [0x55,0xfd,0x75,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01110101-11111101-01010101
uqdech  x23, vl256, mul #9  // 00000100-01111000-11111101-10110111
// CHECK: uqdech  x23, vl256, mul #9 // encoding: [0xb7,0xfd,0x78,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01111000-11111101-10110111
UQDECH  X23, VL256, MUL #9  // 00000100-01111000-11111101-10110111
// CHECK: uqdech  x23, vl256, mul #9 // encoding: [0xb7,0xfd,0x78,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01111000-11111101-10110111
uqdech  x0, pow2  // 00000100-01110000-11111100-00000000
// CHECK: uqdech  x0, pow2 // encoding: [0x00,0xfc,0x70,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01110000-11111100-00000000
UQDECH  X0, POW2  // 00000100-01110000-11111100-00000000
// CHECK: uqdech  x0, pow2 // encoding: [0x00,0xfc,0x70,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01110000-11111100-00000000
