// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
sqdecd  z31.d, all, mul #16  // 00000100-11101111-11001011-11111111
// CHECK: sqdecd  z31.d, all, mul #16 // encoding: [0xff,0xcb,0xef,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11101111-11001011-11111111
SQDECD  Z31.D, ALL, MUL #16  // 00000100-11101111-11001011-11111111
// CHECK: sqdecd  z31.d, all, mul #16 // encoding: [0xff,0xcb,0xef,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11101111-11001011-11111111
sqdecd  z23.d, vl256, mul #9  // 00000100-11101000-11001001-10110111
// CHECK: sqdecd  z23.d, vl256, mul #9 // encoding: [0xb7,0xc9,0xe8,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11101000-11001001-10110111
SQDECD  Z23.D, VL256, MUL #9  // 00000100-11101000-11001001-10110111
// CHECK: sqdecd  z23.d, vl256, mul #9 // encoding: [0xb7,0xc9,0xe8,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11101000-11001001-10110111
sqdecd  z0.d, pow2  // 00000100-11100000-11001000-00000000
// CHECK: sqdecd  z0.d, pow2 // encoding: [0x00,0xc8,0xe0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11100000-11001000-00000000
SQDECD  Z0.D, POW2  // 00000100-11100000-11001000-00000000
// CHECK: sqdecd  z0.d, pow2 // encoding: [0x00,0xc8,0xe0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11100000-11001000-00000000
sqdecd  z21.d, vl32, mul #6  // 00000100-11100101-11001001-01010101
// CHECK: sqdecd  z21.d, vl32, mul #6 // encoding: [0x55,0xc9,0xe5,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11100101-11001001-01010101
SQDECD  Z21.D, VL32, MUL #6  // 00000100-11100101-11001001-01010101
// CHECK: sqdecd  z21.d, vl32, mul #6 // encoding: [0x55,0xc9,0xe5,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11100101-11001001-01010101
