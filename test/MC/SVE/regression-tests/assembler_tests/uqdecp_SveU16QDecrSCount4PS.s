// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
uqdecp  w0, p0.h  // 00100101-01101011-10001000-00000000
// CHECK: uqdecp  w0, p0.h // encoding: [0x00,0x88,0x6b,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01101011-10001000-00000000
UQDECP  W0, P0.H  // 00100101-01101011-10001000-00000000
// CHECK: uqdecp  w0, p0.h // encoding: [0x00,0x88,0x6b,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01101011-10001000-00000000
uqdecp  w21, p10.h  // 00100101-01101011-10001001-01010101
// CHECK: uqdecp  w21, p10.h // encoding: [0x55,0x89,0x6b,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01101011-10001001-01010101
UQDECP  W21, P10.H  // 00100101-01101011-10001001-01010101
// CHECK: uqdecp  w21, p10.h // encoding: [0x55,0x89,0x6b,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01101011-10001001-01010101
uqdecp  wzr, p15.h  // 00100101-01101011-10001001-11111111
// CHECK: uqdecp  wzr, p15.h // encoding: [0xff,0x89,0x6b,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01101011-10001001-11111111
UQDECP  WZR, P15.H  // 00100101-01101011-10001001-11111111
// CHECK: uqdecp  wzr, p15.h // encoding: [0xff,0x89,0x6b,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01101011-10001001-11111111
uqdecp  w23, p13.h  // 00100101-01101011-10001001-10110111
// CHECK: uqdecp  w23, p13.h // encoding: [0xb7,0x89,0x6b,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01101011-10001001-10110111
UQDECP  W23, P13.H  // 00100101-01101011-10001001-10110111
// CHECK: uqdecp  w23, p13.h // encoding: [0xb7,0x89,0x6b,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01101011-10001001-10110111
