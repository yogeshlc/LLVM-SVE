// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
uqdecp  w23, p13.d  // 00100101-11101011-10001001-10110111
// CHECK: uqdecp  w23, p13.d // encoding: [0xb7,0x89,0xeb,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11101011-10001001-10110111
UQDECP  W23, P13.D  // 00100101-11101011-10001001-10110111
// CHECK: uqdecp  w23, p13.d // encoding: [0xb7,0x89,0xeb,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11101011-10001001-10110111
uqdecp  w21, p10.d  // 00100101-11101011-10001001-01010101
// CHECK: uqdecp  w21, p10.d // encoding: [0x55,0x89,0xeb,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11101011-10001001-01010101
UQDECP  W21, P10.D  // 00100101-11101011-10001001-01010101
// CHECK: uqdecp  w21, p10.d // encoding: [0x55,0x89,0xeb,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11101011-10001001-01010101
uqdecp  wzr, p15.d  // 00100101-11101011-10001001-11111111
// CHECK: uqdecp  wzr, p15.d // encoding: [0xff,0x89,0xeb,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11101011-10001001-11111111
UQDECP  WZR, P15.D  // 00100101-11101011-10001001-11111111
// CHECK: uqdecp  wzr, p15.d // encoding: [0xff,0x89,0xeb,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11101011-10001001-11111111
uqdecp  w0, p0.d  // 00100101-11101011-10001000-00000000
// CHECK: uqdecp  w0, p0.d // encoding: [0x00,0x88,0xeb,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11101011-10001000-00000000
UQDECP  W0, P0.D  // 00100101-11101011-10001000-00000000
// CHECK: uqdecp  w0, p0.d // encoding: [0x00,0x88,0xeb,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11101011-10001000-00000000
