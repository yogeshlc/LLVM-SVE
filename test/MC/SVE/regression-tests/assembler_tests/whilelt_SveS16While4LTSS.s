// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
whilelt p5.h, w10, w21  // 00100101-01110101-00000101-01000101
// CHECK: whilelt p5.h, w10, w21 // encoding: [0x45,0x05,0x75,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01110101-00000101-01000101
WHILELT P5.H, W10, W21  // 00100101-01110101-00000101-01000101
// CHECK: whilelt p5.h, w10, w21 // encoding: [0x45,0x05,0x75,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01110101-00000101-01000101
whilelt p7.h, w13, w8  // 00100101-01101000-00000101-10100111
// CHECK: whilelt p7.h, w13, w8 // encoding: [0xa7,0x05,0x68,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01101000-00000101-10100111
WHILELT P7.H, W13, W8  // 00100101-01101000-00000101-10100111
// CHECK: whilelt p7.h, w13, w8 // encoding: [0xa7,0x05,0x68,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01101000-00000101-10100111
whilelt p0.h, w0, w0  // 00100101-01100000-00000100-00000000
// CHECK: whilelt p0.h, w0, w0 // encoding: [0x00,0x04,0x60,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01100000-00000100-00000000
WHILELT P0.H, W0, W0  // 00100101-01100000-00000100-00000000
// CHECK: whilelt p0.h, w0, w0 // encoding: [0x00,0x04,0x60,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01100000-00000100-00000000
whilelt p15.h, wzr, wzr  // 00100101-01111111-00000111-11101111
// CHECK: whilelt p15.h, wzr, wzr // encoding: [0xef,0x07,0x7f,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01111111-00000111-11101111
WHILELT P15.H, WZR, WZR  // 00100101-01111111-00000111-11101111
// CHECK: whilelt p15.h, wzr, wzr // encoding: [0xef,0x07,0x7f,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01111111-00000111-11101111
