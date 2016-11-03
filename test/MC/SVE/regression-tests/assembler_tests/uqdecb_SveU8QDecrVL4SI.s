// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
uqdecb  wzr, all, mul #16  // 00000100-00101111-11111111-11111111
// CHECK: uqdecb  wzr, all, mul #16 // encoding: [0xff,0xff,0x2f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00101111-11111111-11111111
UQDECB  WZR, ALL, MUL #16  // 00000100-00101111-11111111-11111111
// CHECK: uqdecb  wzr, all, mul #16 // encoding: [0xff,0xff,0x2f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00101111-11111111-11111111
uqdecb  w23, vl256, mul #9  // 00000100-00101000-11111101-10110111
// CHECK: uqdecb  w23, vl256, mul #9 // encoding: [0xb7,0xfd,0x28,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00101000-11111101-10110111
UQDECB  W23, VL256, MUL #9  // 00000100-00101000-11111101-10110111
// CHECK: uqdecb  w23, vl256, mul #9 // encoding: [0xb7,0xfd,0x28,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00101000-11111101-10110111
uqdecb  w0, pow2  // 00000100-00100000-11111100-00000000
// CHECK: uqdecb  w0, pow2 // encoding: [0x00,0xfc,0x20,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00100000-11111100-00000000
UQDECB  W0, POW2  // 00000100-00100000-11111100-00000000
// CHECK: uqdecb  w0, pow2 // encoding: [0x00,0xfc,0x20,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00100000-11111100-00000000
uqdecb  w21, vl32, mul #6  // 00000100-00100101-11111101-01010101
// CHECK: uqdecb  w21, vl32, mul #6 // encoding: [0x55,0xfd,0x25,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00100101-11111101-01010101
UQDECB  W21, VL32, MUL #6  // 00000100-00100101-11111101-01010101
// CHECK: uqdecb  w21, vl32, mul #6 // encoding: [0x55,0xfd,0x25,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00100101-11111101-01010101
