// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
sqdecb  x23, w23, vl256, mul #9  // 00000100-00101000-11111001-10110111
// CHECK: sqdecb  x23, w23, vl256, mul #9 // encoding: [0xb7,0xf9,0x28,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00101000-11111001-10110111
SQDECB  X23, W23, VL256, MUL #9  // 00000100-00101000-11111001-10110111
// CHECK: sqdecb  x23, w23, vl256, mul #9 // encoding: [0xb7,0xf9,0x28,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00101000-11111001-10110111
sqdecb  x21, w21, vl32, mul #6  // 00000100-00100101-11111001-01010101
// CHECK: sqdecb  x21, w21, vl32, mul #6 // encoding: [0x55,0xf9,0x25,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00100101-11111001-01010101
SQDECB  X21, W21, VL32, MUL #6  // 00000100-00100101-11111001-01010101
// CHECK: sqdecb  x21, w21, vl32, mul #6 // encoding: [0x55,0xf9,0x25,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00100101-11111001-01010101
sqdecb  x0, w0, pow2  // 00000100-00100000-11111000-00000000
// CHECK: sqdecb  x0, w0, pow2 // encoding: [0x00,0xf8,0x20,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00100000-11111000-00000000
SQDECB  X0, W0, POW2  // 00000100-00100000-11111000-00000000
// CHECK: sqdecb  x0, w0, pow2 // encoding: [0x00,0xf8,0x20,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00100000-11111000-00000000
sqdecb  xzr, wzr, all, mul #16  // 00000100-00101111-11111011-11111111
// CHECK: sqdecb  xzr, wzr, all, mul #16 // encoding: [0xff,0xfb,0x2f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00101111-11111011-11111111
SQDECB  XZR, WZR, ALL, MUL #16  // 00000100-00101111-11111011-11111111
// CHECK: sqdecb  xzr, wzr, all, mul #16 // encoding: [0xff,0xfb,0x2f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00101111-11111011-11111111
