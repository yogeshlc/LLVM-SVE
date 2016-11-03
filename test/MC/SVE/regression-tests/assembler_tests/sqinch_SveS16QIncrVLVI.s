// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
sqinch  z0.h, pow2  // 00000100-01100000-11000000-00000000
// CHECK: sqinch  z0.h, pow2 // encoding: [0x00,0xc0,0x60,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01100000-11000000-00000000
SQINCH  Z0.H, POW2  // 00000100-01100000-11000000-00000000
// CHECK: sqinch  z0.h, pow2 // encoding: [0x00,0xc0,0x60,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01100000-11000000-00000000
sqinch  z31.h, all, mul #16  // 00000100-01101111-11000011-11111111
// CHECK: sqinch  z31.h, all, mul #16 // encoding: [0xff,0xc3,0x6f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01101111-11000011-11111111
SQINCH  Z31.H, ALL, MUL #16  // 00000100-01101111-11000011-11111111
// CHECK: sqinch  z31.h, all, mul #16 // encoding: [0xff,0xc3,0x6f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01101111-11000011-11111111
sqinch  z21.h, vl32, mul #6  // 00000100-01100101-11000001-01010101
// CHECK: sqinch  z21.h, vl32, mul #6 // encoding: [0x55,0xc1,0x65,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01100101-11000001-01010101
SQINCH  Z21.H, VL32, MUL #6  // 00000100-01100101-11000001-01010101
// CHECK: sqinch  z21.h, vl32, mul #6 // encoding: [0x55,0xc1,0x65,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01100101-11000001-01010101
sqinch  z23.h, vl256, mul #9  // 00000100-01101000-11000001-10110111
// CHECK: sqinch  z23.h, vl256, mul #9 // encoding: [0xb7,0xc1,0x68,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01101000-11000001-10110111
SQINCH  Z23.H, VL256, MUL #9  // 00000100-01101000-11000001-10110111
// CHECK: sqinch  z23.h, vl256, mul #9 // encoding: [0xb7,0xc1,0x68,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01101000-11000001-10110111
