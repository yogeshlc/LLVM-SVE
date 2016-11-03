// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
sqdech  z31.h, all, mul #16  // 00000100-01101111-11001011-11111111
// CHECK: sqdech  z31.h, all, mul #16 // encoding: [0xff,0xcb,0x6f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01101111-11001011-11111111
SQDECH  Z31.H, ALL, MUL #16  // 00000100-01101111-11001011-11111111
// CHECK: sqdech  z31.h, all, mul #16 // encoding: [0xff,0xcb,0x6f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01101111-11001011-11111111
sqdech  z0.h, pow2  // 00000100-01100000-11001000-00000000
// CHECK: sqdech  z0.h, pow2 // encoding: [0x00,0xc8,0x60,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01100000-11001000-00000000
SQDECH  Z0.H, POW2  // 00000100-01100000-11001000-00000000
// CHECK: sqdech  z0.h, pow2 // encoding: [0x00,0xc8,0x60,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01100000-11001000-00000000
sqdech  z23.h, vl256, mul #9  // 00000100-01101000-11001001-10110111
// CHECK: sqdech  z23.h, vl256, mul #9 // encoding: [0xb7,0xc9,0x68,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01101000-11001001-10110111
SQDECH  Z23.H, VL256, MUL #9  // 00000100-01101000-11001001-10110111
// CHECK: sqdech  z23.h, vl256, mul #9 // encoding: [0xb7,0xc9,0x68,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01101000-11001001-10110111
sqdech  z21.h, vl32, mul #6  // 00000100-01100101-11001001-01010101
// CHECK: sqdech  z21.h, vl32, mul #6 // encoding: [0x55,0xc9,0x65,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01100101-11001001-01010101
SQDECH  Z21.H, VL32, MUL #6  // 00000100-01100101-11001001-01010101
// CHECK: sqdech  z21.h, vl32, mul #6 // encoding: [0x55,0xc9,0x65,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01100101-11001001-01010101
