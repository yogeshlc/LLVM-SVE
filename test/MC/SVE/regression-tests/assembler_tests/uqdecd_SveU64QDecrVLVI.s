// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
uqdecd  z31.d, all, mul #16  // 00000100-11101111-11001111-11111111
// CHECK: uqdecd  z31.d, all, mul #16 // encoding: [0xff,0xcf,0xef,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11101111-11001111-11111111
UQDECD  Z31.D, ALL, MUL #16  // 00000100-11101111-11001111-11111111
// CHECK: uqdecd  z31.d, all, mul #16 // encoding: [0xff,0xcf,0xef,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11101111-11001111-11111111
uqdecd  z21.d, vl32, mul #6  // 00000100-11100101-11001101-01010101
// CHECK: uqdecd  z21.d, vl32, mul #6 // encoding: [0x55,0xcd,0xe5,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11100101-11001101-01010101
UQDECD  Z21.D, VL32, MUL #6  // 00000100-11100101-11001101-01010101
// CHECK: uqdecd  z21.d, vl32, mul #6 // encoding: [0x55,0xcd,0xe5,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11100101-11001101-01010101
uqdecd  z23.d, vl256, mul #9  // 00000100-11101000-11001101-10110111
// CHECK: uqdecd  z23.d, vl256, mul #9 // encoding: [0xb7,0xcd,0xe8,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11101000-11001101-10110111
UQDECD  Z23.D, VL256, MUL #9  // 00000100-11101000-11001101-10110111
// CHECK: uqdecd  z23.d, vl256, mul #9 // encoding: [0xb7,0xcd,0xe8,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11101000-11001101-10110111
uqdecd  z0.d, pow2  // 00000100-11100000-11001100-00000000
// CHECK: uqdecd  z0.d, pow2 // encoding: [0x00,0xcc,0xe0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11100000-11001100-00000000
UQDECD  Z0.D, POW2  // 00000100-11100000-11001100-00000000
// CHECK: uqdecd  z0.d, pow2 // encoding: [0x00,0xcc,0xe0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11100000-11001100-00000000
