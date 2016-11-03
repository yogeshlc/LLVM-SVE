// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
str     z21, [x10, #173, mul vl]  // 11100101-10010101-01010101-01010101
// CHECK: str     z21, [x10, #173, mul vl] // encoding: [0x55,0x55,0x95,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-10010101-01010101-01010101
STR     Z21, [X10, #173, MUL VL]  // 11100101-10010101-01010101-01010101
// CHECK: str     z21, [x10, #173, mul vl] // encoding: [0x55,0x55,0x95,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-10010101-01010101-01010101
str     z31, [sp, #-1, mul vl]  // 11100101-10111111-01011111-11111111
// CHECK: str     z31, [sp, #-1, mul vl] // encoding: [0xff,0x5f,0xbf,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-10111111-01011111-11111111
STR     Z31, [SP, #-1, MUL VL]  // 11100101-10111111-01011111-11111111
// CHECK: str     z31, [sp, #-1, mul vl] // encoding: [0xff,0x5f,0xbf,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-10111111-01011111-11111111
str     z23, [x13, #67, mul vl]  // 11100101-10001000-01001101-10110111
// CHECK: str     z23, [x13, #67, mul vl] // encoding: [0xb7,0x4d,0x88,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-10001000-01001101-10110111
STR     Z23, [X13, #67, MUL VL]  // 11100101-10001000-01001101-10110111
// CHECK: str     z23, [x13, #67, mul vl] // encoding: [0xb7,0x4d,0x88,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-10001000-01001101-10110111
str     z0, [x0]  // 11100101-10000000-01000000-00000000
// CHECK: str     z0, [x0] // encoding: [0x00,0x40,0x80,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-10000000-01000000-00000000
STR     Z0, [X0]  // 11100101-10000000-01000000-00000000
// CHECK: str     z0, [x0] // encoding: [0x00,0x40,0x80,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-10000000-01000000-00000000
