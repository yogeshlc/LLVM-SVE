// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
whilelo p15.h, wzr, wzr  // 00100101-01111111-00001111-11101111
// CHECK: whilelo p15.h, wzr, wzr // encoding: [0xef,0x0f,0x7f,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01111111-00001111-11101111
WHILELO P15.H, WZR, WZR  // 00100101-01111111-00001111-11101111
// CHECK: whilelo p15.h, wzr, wzr // encoding: [0xef,0x0f,0x7f,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01111111-00001111-11101111
whilelo p7.h, w13, w8  // 00100101-01101000-00001101-10100111
// CHECK: whilelo p7.h, w13, w8 // encoding: [0xa7,0x0d,0x68,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01101000-00001101-10100111
WHILELO P7.H, W13, W8  // 00100101-01101000-00001101-10100111
// CHECK: whilelo p7.h, w13, w8 // encoding: [0xa7,0x0d,0x68,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01101000-00001101-10100111
whilelo p5.h, w10, w21  // 00100101-01110101-00001101-01000101
// CHECK: whilelo p5.h, w10, w21 // encoding: [0x45,0x0d,0x75,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01110101-00001101-01000101
WHILELO P5.H, W10, W21  // 00100101-01110101-00001101-01000101
// CHECK: whilelo p5.h, w10, w21 // encoding: [0x45,0x0d,0x75,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01110101-00001101-01000101
whilelo p0.h, w0, w0  // 00100101-01100000-00001100-00000000
// CHECK: whilelo p0.h, w0, w0 // encoding: [0x00,0x0c,0x60,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01100000-00001100-00000000
WHILELO P0.H, W0, W0  // 00100101-01100000-00001100-00000000
// CHECK: whilelo p0.h, w0, w0 // encoding: [0x00,0x0c,0x60,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01100000-00001100-00000000
