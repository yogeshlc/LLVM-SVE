// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
sqinch  x21, vl32, mul #6  // 00000100-01110101-11110001-01010101
// CHECK: sqinch  x21, vl32, mul #6 // encoding: [0x55,0xf1,0x75,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01110101-11110001-01010101
SQINCH  X21, VL32, MUL #6  // 00000100-01110101-11110001-01010101
// CHECK: sqinch  x21, vl32, mul #6 // encoding: [0x55,0xf1,0x75,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01110101-11110001-01010101
sqinch  xzr, all, mul #16  // 00000100-01111111-11110011-11111111
// CHECK: sqinch  xzr, all, mul #16 // encoding: [0xff,0xf3,0x7f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01111111-11110011-11111111
SQINCH  XZR, ALL, MUL #16  // 00000100-01111111-11110011-11111111
// CHECK: sqinch  xzr, all, mul #16 // encoding: [0xff,0xf3,0x7f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01111111-11110011-11111111
sqinch  x0, pow2  // 00000100-01110000-11110000-00000000
// CHECK: sqinch  x0, pow2 // encoding: [0x00,0xf0,0x70,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01110000-11110000-00000000
SQINCH  X0, POW2  // 00000100-01110000-11110000-00000000
// CHECK: sqinch  x0, pow2 // encoding: [0x00,0xf0,0x70,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01110000-11110000-00000000
sqinch  x23, vl256, mul #9  // 00000100-01111000-11110001-10110111
// CHECK: sqinch  x23, vl256, mul #9 // encoding: [0xb7,0xf1,0x78,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01111000-11110001-10110111
SQINCH  X23, VL256, MUL #9  // 00000100-01111000-11110001-10110111
// CHECK: sqinch  x23, vl256, mul #9 // encoding: [0xb7,0xf1,0x78,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01111000-11110001-10110111
