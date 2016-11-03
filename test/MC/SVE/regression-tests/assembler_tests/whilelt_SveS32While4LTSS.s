// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
whilelt p7.s, w13, w8  // 00100101-10101000-00000101-10100111
// CHECK: whilelt p7.s, w13, w8 // encoding: [0xa7,0x05,0xa8,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10101000-00000101-10100111
WHILELT P7.S, W13, W8  // 00100101-10101000-00000101-10100111
// CHECK: whilelt p7.s, w13, w8 // encoding: [0xa7,0x05,0xa8,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10101000-00000101-10100111
whilelt p15.s, wzr, wzr  // 00100101-10111111-00000111-11101111
// CHECK: whilelt p15.s, wzr, wzr // encoding: [0xef,0x07,0xbf,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10111111-00000111-11101111
WHILELT P15.S, WZR, WZR  // 00100101-10111111-00000111-11101111
// CHECK: whilelt p15.s, wzr, wzr // encoding: [0xef,0x07,0xbf,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10111111-00000111-11101111
whilelt p0.s, w0, w0  // 00100101-10100000-00000100-00000000
// CHECK: whilelt p0.s, w0, w0 // encoding: [0x00,0x04,0xa0,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10100000-00000100-00000000
WHILELT P0.S, W0, W0  // 00100101-10100000-00000100-00000000
// CHECK: whilelt p0.s, w0, w0 // encoding: [0x00,0x04,0xa0,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10100000-00000100-00000000
whilelt p5.s, w10, w21  // 00100101-10110101-00000101-01000101
// CHECK: whilelt p5.s, w10, w21 // encoding: [0x45,0x05,0xb5,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10110101-00000101-01000101
WHILELT P5.S, W10, W21  // 00100101-10110101-00000101-01000101
// CHECK: whilelt p5.s, w10, w21 // encoding: [0x45,0x05,0xb5,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10110101-00000101-01000101
