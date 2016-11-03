// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
whilelo p7.b, w13, w8  // 00100101-00101000-00001101-10100111
// CHECK: whilelo p7.b, w13, w8 // encoding: [0xa7,0x0d,0x28,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00101000-00001101-10100111
WHILELO P7.B, W13, W8  // 00100101-00101000-00001101-10100111
// CHECK: whilelo p7.b, w13, w8 // encoding: [0xa7,0x0d,0x28,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00101000-00001101-10100111
whilelo p5.b, w10, w21  // 00100101-00110101-00001101-01000101
// CHECK: whilelo p5.b, w10, w21 // encoding: [0x45,0x0d,0x35,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00110101-00001101-01000101
WHILELO P5.B, W10, W21  // 00100101-00110101-00001101-01000101
// CHECK: whilelo p5.b, w10, w21 // encoding: [0x45,0x0d,0x35,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00110101-00001101-01000101
whilelo p0.b, w0, w0  // 00100101-00100000-00001100-00000000
// CHECK: whilelo p0.b, w0, w0 // encoding: [0x00,0x0c,0x20,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00100000-00001100-00000000
WHILELO P0.B, W0, W0  // 00100101-00100000-00001100-00000000
// CHECK: whilelo p0.b, w0, w0 // encoding: [0x00,0x0c,0x20,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00100000-00001100-00000000
whilelo p15.b, wzr, wzr  // 00100101-00111111-00001111-11101111
// CHECK: whilelo p15.b, wzr, wzr // encoding: [0xef,0x0f,0x3f,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00111111-00001111-11101111
WHILELO P15.B, WZR, WZR  // 00100101-00111111-00001111-11101111
// CHECK: whilelo p15.b, wzr, wzr // encoding: [0xef,0x0f,0x3f,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00111111-00001111-11101111
