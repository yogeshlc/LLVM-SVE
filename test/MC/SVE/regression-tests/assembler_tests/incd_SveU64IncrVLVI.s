// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
incd    z31.d, all, mul #16  // 00000100-11111111-11000011-11111111
// CHECK: incd    z31.d, all, mul #16 // encoding: [0xff,0xc3,0xff,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11111111-11000011-11111111
INCD    Z31.D, ALL, MUL #16  // 00000100-11111111-11000011-11111111
// CHECK: incd    z31.d, all, mul #16 // encoding: [0xff,0xc3,0xff,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11111111-11000011-11111111
incd    z0.d, pow2  // 00000100-11110000-11000000-00000000
// CHECK: incd    z0.d, pow2 // encoding: [0x00,0xc0,0xf0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11110000-11000000-00000000
INCD    Z0.D, POW2  // 00000100-11110000-11000000-00000000
// CHECK: incd    z0.d, pow2 // encoding: [0x00,0xc0,0xf0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11110000-11000000-00000000
incd    z23.d, vl256, mul #9  // 00000100-11111000-11000001-10110111
// CHECK: incd    z23.d, vl256, mul #9 // encoding: [0xb7,0xc1,0xf8,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11111000-11000001-10110111
INCD    Z23.D, VL256, MUL #9  // 00000100-11111000-11000001-10110111
// CHECK: incd    z23.d, vl256, mul #9 // encoding: [0xb7,0xc1,0xf8,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11111000-11000001-10110111
incd    z21.d, vl32, mul #6  // 00000100-11110101-11000001-01010101
// CHECK: incd    z21.d, vl32, mul #6 // encoding: [0x55,0xc1,0xf5,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11110101-11000001-01010101
INCD    Z21.D, VL32, MUL #6  // 00000100-11110101-11000001-01010101
// CHECK: incd    z21.d, vl32, mul #6 // encoding: [0x55,0xc1,0xf5,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11110101-11000001-01010101
