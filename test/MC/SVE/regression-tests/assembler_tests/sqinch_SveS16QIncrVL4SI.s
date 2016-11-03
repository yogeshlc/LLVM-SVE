// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
sqinch  xzr, wzr, all, mul #16  // 00000100-01101111-11110011-11111111
// CHECK: sqinch  xzr, wzr, all, mul #16 // encoding: [0xff,0xf3,0x6f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01101111-11110011-11111111
SQINCH  XZR, WZR, ALL, MUL #16  // 00000100-01101111-11110011-11111111
// CHECK: sqinch  xzr, wzr, all, mul #16 // encoding: [0xff,0xf3,0x6f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01101111-11110011-11111111
sqinch  x23, w23, vl256, mul #9  // 00000100-01101000-11110001-10110111
// CHECK: sqinch  x23, w23, vl256, mul #9 // encoding: [0xb7,0xf1,0x68,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01101000-11110001-10110111
SQINCH  X23, W23, VL256, MUL #9  // 00000100-01101000-11110001-10110111
// CHECK: sqinch  x23, w23, vl256, mul #9 // encoding: [0xb7,0xf1,0x68,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01101000-11110001-10110111
sqinch  x21, w21, vl32, mul #6  // 00000100-01100101-11110001-01010101
// CHECK: sqinch  x21, w21, vl32, mul #6 // encoding: [0x55,0xf1,0x65,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01100101-11110001-01010101
SQINCH  X21, W21, VL32, MUL #6  // 00000100-01100101-11110001-01010101
// CHECK: sqinch  x21, w21, vl32, mul #6 // encoding: [0x55,0xf1,0x65,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01100101-11110001-01010101
sqinch  x0, w0, pow2  // 00000100-01100000-11110000-00000000
// CHECK: sqinch  x0, w0, pow2 // encoding: [0x00,0xf0,0x60,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01100000-11110000-00000000
SQINCH  X0, W0, POW2  // 00000100-01100000-11110000-00000000
// CHECK: sqinch  x0, w0, pow2 // encoding: [0x00,0xf0,0x60,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01100000-11110000-00000000
