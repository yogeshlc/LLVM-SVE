// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
whilels p15.d, wzr, wzr  // 00100101-11111111-00001111-11111111
// CHECK: whilels p15.d, wzr, wzr // encoding: [0xff,0x0f,0xff,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11111111-00001111-11111111
WHILELS P15.D, WZR, WZR  // 00100101-11111111-00001111-11111111
// CHECK: whilels p15.d, wzr, wzr // encoding: [0xff,0x0f,0xff,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11111111-00001111-11111111
whilels p5.d, w10, w21  // 00100101-11110101-00001101-01010101
// CHECK: whilels p5.d, w10, w21 // encoding: [0x55,0x0d,0xf5,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11110101-00001101-01010101
WHILELS P5.D, W10, W21  // 00100101-11110101-00001101-01010101
// CHECK: whilels p5.d, w10, w21 // encoding: [0x55,0x0d,0xf5,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11110101-00001101-01010101
whilels p7.d, w13, w8  // 00100101-11101000-00001101-10110111
// CHECK: whilels p7.d, w13, w8 // encoding: [0xb7,0x0d,0xe8,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11101000-00001101-10110111
WHILELS P7.D, W13, W8  // 00100101-11101000-00001101-10110111
// CHECK: whilels p7.d, w13, w8 // encoding: [0xb7,0x0d,0xe8,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11101000-00001101-10110111
whilels p0.d, w0, w0  // 00100101-11100000-00001100-00010000
// CHECK: whilels p0.d, w0, w0 // encoding: [0x10,0x0c,0xe0,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11100000-00001100-00010000
WHILELS P0.D, W0, W0  // 00100101-11100000-00001100-00010000
// CHECK: whilels p0.d, w0, w0 // encoding: [0x10,0x0c,0xe0,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11100000-00001100-00010000
