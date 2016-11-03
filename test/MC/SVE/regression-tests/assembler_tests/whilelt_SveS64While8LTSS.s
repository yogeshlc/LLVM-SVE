// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
whilelt p5.d, x10, x21  // 00100101-11110101-00010101-01000101
// CHECK: whilelt p5.d, x10, x21 // encoding: [0x45,0x15,0xf5,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11110101-00010101-01000101
WHILELT P5.D, X10, X21  // 00100101-11110101-00010101-01000101
// CHECK: whilelt p5.d, x10, x21 // encoding: [0x45,0x15,0xf5,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11110101-00010101-01000101
whilelt p15.d, xzr, xzr  // 00100101-11111111-00010111-11101111
// CHECK: whilelt p15.d, xzr, xzr // encoding: [0xef,0x17,0xff,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11111111-00010111-11101111
WHILELT P15.D, XZR, XZR  // 00100101-11111111-00010111-11101111
// CHECK: whilelt p15.d, xzr, xzr // encoding: [0xef,0x17,0xff,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11111111-00010111-11101111
whilelt p0.d, x0, x0  // 00100101-11100000-00010100-00000000
// CHECK: whilelt p0.d, x0, x0 // encoding: [0x00,0x14,0xe0,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11100000-00010100-00000000
WHILELT P0.D, X0, X0  // 00100101-11100000-00010100-00000000
// CHECK: whilelt p0.d, x0, x0 // encoding: [0x00,0x14,0xe0,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11100000-00010100-00000000
whilelt p7.d, x13, x8  // 00100101-11101000-00010101-10100111
// CHECK: whilelt p7.d, x13, x8 // encoding: [0xa7,0x15,0xe8,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11101000-00010101-10100111
WHILELT P7.D, X13, X8  // 00100101-11101000-00010101-10100111
// CHECK: whilelt p7.d, x13, x8 // encoding: [0xa7,0x15,0xe8,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11101000-00010101-10100111
