// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
whilels p7.b, x13, x8  // 00100101-00101000-00011101-10110111
// CHECK: whilels p7.b, x13, x8 // encoding: [0xb7,0x1d,0x28,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00101000-00011101-10110111
WHILELS P7.B, X13, X8  // 00100101-00101000-00011101-10110111
// CHECK: whilels p7.b, x13, x8 // encoding: [0xb7,0x1d,0x28,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00101000-00011101-10110111
whilels p5.b, x10, x21  // 00100101-00110101-00011101-01010101
// CHECK: whilels p5.b, x10, x21 // encoding: [0x55,0x1d,0x35,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00110101-00011101-01010101
WHILELS P5.B, X10, X21  // 00100101-00110101-00011101-01010101
// CHECK: whilels p5.b, x10, x21 // encoding: [0x55,0x1d,0x35,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00110101-00011101-01010101
whilels p15.b, xzr, xzr  // 00100101-00111111-00011111-11111111
// CHECK: whilels p15.b, xzr, xzr // encoding: [0xff,0x1f,0x3f,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00111111-00011111-11111111
WHILELS P15.B, XZR, XZR  // 00100101-00111111-00011111-11111111
// CHECK: whilels p15.b, xzr, xzr // encoding: [0xff,0x1f,0x3f,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00111111-00011111-11111111
whilels p0.b, x0, x0  // 00100101-00100000-00011100-00010000
// CHECK: whilels p0.b, x0, x0 // encoding: [0x10,0x1c,0x20,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00100000-00011100-00010000
WHILELS P0.B, X0, X0  // 00100101-00100000-00011100-00010000
// CHECK: whilels p0.b, x0, x0 // encoding: [0x10,0x1c,0x20,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00100000-00011100-00010000
