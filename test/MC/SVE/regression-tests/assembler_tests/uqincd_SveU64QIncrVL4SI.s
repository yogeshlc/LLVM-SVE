// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
uqincd  w0, pow2  // 00000100-11100000-11110100-00000000
// CHECK: uqincd  w0, pow2 // encoding: [0x00,0xf4,0xe0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11100000-11110100-00000000
UQINCD  W0, POW2  // 00000100-11100000-11110100-00000000
// CHECK: uqincd  w0, pow2 // encoding: [0x00,0xf4,0xe0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11100000-11110100-00000000
uqincd  w23, vl256, mul #9  // 00000100-11101000-11110101-10110111
// CHECK: uqincd  w23, vl256, mul #9 // encoding: [0xb7,0xf5,0xe8,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11101000-11110101-10110111
UQINCD  W23, VL256, MUL #9  // 00000100-11101000-11110101-10110111
// CHECK: uqincd  w23, vl256, mul #9 // encoding: [0xb7,0xf5,0xe8,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11101000-11110101-10110111
uqincd  w21, vl32, mul #6  // 00000100-11100101-11110101-01010101
// CHECK: uqincd  w21, vl32, mul #6 // encoding: [0x55,0xf5,0xe5,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11100101-11110101-01010101
UQINCD  W21, VL32, MUL #6  // 00000100-11100101-11110101-01010101
// CHECK: uqincd  w21, vl32, mul #6 // encoding: [0x55,0xf5,0xe5,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11100101-11110101-01010101
uqincd  wzr, all, mul #16  // 00000100-11101111-11110111-11111111
// CHECK: uqincd  wzr, all, mul #16 // encoding: [0xff,0xf7,0xef,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11101111-11110111-11111111
UQINCD  WZR, ALL, MUL #16  // 00000100-11101111-11110111-11111111
// CHECK: uqincd  wzr, all, mul #16 // encoding: [0xff,0xf7,0xef,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11101111-11110111-11111111
