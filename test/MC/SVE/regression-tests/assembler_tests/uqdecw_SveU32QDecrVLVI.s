// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
uqdecw  z0.s, pow2  // 00000100-10100000-11001100-00000000
// CHECK: uqdecw  z0.s, pow2 // encoding: [0x00,0xcc,0xa0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10100000-11001100-00000000
UQDECW  Z0.S, POW2  // 00000100-10100000-11001100-00000000
// CHECK: uqdecw  z0.s, pow2 // encoding: [0x00,0xcc,0xa0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10100000-11001100-00000000
uqdecw  z31.s, all, mul #16  // 00000100-10101111-11001111-11111111
// CHECK: uqdecw  z31.s, all, mul #16 // encoding: [0xff,0xcf,0xaf,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10101111-11001111-11111111
UQDECW  Z31.S, ALL, MUL #16  // 00000100-10101111-11001111-11111111
// CHECK: uqdecw  z31.s, all, mul #16 // encoding: [0xff,0xcf,0xaf,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10101111-11001111-11111111
uqdecw  z23.s, vl256, mul #9  // 00000100-10101000-11001101-10110111
// CHECK: uqdecw  z23.s, vl256, mul #9 // encoding: [0xb7,0xcd,0xa8,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10101000-11001101-10110111
UQDECW  Z23.S, VL256, MUL #9  // 00000100-10101000-11001101-10110111
// CHECK: uqdecw  z23.s, vl256, mul #9 // encoding: [0xb7,0xcd,0xa8,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10101000-11001101-10110111
uqdecw  z21.s, vl32, mul #6  // 00000100-10100101-11001101-01010101
// CHECK: uqdecw  z21.s, vl32, mul #6 // encoding: [0x55,0xcd,0xa5,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10100101-11001101-01010101
UQDECW  Z21.S, VL32, MUL #6  // 00000100-10100101-11001101-01010101
// CHECK: uqdecw  z21.s, vl32, mul #6 // encoding: [0x55,0xcd,0xa5,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10100101-11001101-01010101
