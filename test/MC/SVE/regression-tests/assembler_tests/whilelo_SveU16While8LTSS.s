// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
whilelo p7.h, x13, x8  // 00100101-01101000-00011101-10100111
// CHECK: whilelo p7.h, x13, x8 // encoding: [0xa7,0x1d,0x68,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01101000-00011101-10100111
WHILELO P7.H, X13, X8  // 00100101-01101000-00011101-10100111
// CHECK: whilelo p7.h, x13, x8 // encoding: [0xa7,0x1d,0x68,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01101000-00011101-10100111
whilelo p0.h, x0, x0  // 00100101-01100000-00011100-00000000
// CHECK: whilelo p0.h, x0, x0 // encoding: [0x00,0x1c,0x60,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01100000-00011100-00000000
WHILELO P0.H, X0, X0  // 00100101-01100000-00011100-00000000
// CHECK: whilelo p0.h, x0, x0 // encoding: [0x00,0x1c,0x60,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01100000-00011100-00000000
whilelo p5.h, x10, x21  // 00100101-01110101-00011101-01000101
// CHECK: whilelo p5.h, x10, x21 // encoding: [0x45,0x1d,0x75,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01110101-00011101-01000101
WHILELO P5.H, X10, X21  // 00100101-01110101-00011101-01000101
// CHECK: whilelo p5.h, x10, x21 // encoding: [0x45,0x1d,0x75,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01110101-00011101-01000101
whilelo p15.h, xzr, xzr  // 00100101-01111111-00011111-11101111
// CHECK: whilelo p15.h, xzr, xzr // encoding: [0xef,0x1f,0x7f,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01111111-00011111-11101111
WHILELO P15.H, XZR, XZR  // 00100101-01111111-00011111-11101111
// CHECK: whilelo p15.h, xzr, xzr // encoding: [0xef,0x1f,0x7f,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01111111-00011111-11101111
