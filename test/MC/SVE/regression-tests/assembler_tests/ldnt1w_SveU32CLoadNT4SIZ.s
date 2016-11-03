// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ldnt1w  {z0.s}, p0/z, [x0]  // 10100101-00000000-11100000-00000000
// CHECK: ldnt1w  {z0.s}, p0/z, [x0] // encoding: [0x00,0xe0,0x00,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-00000000-11100000-00000000
LDNT1W  {Z0.S}, P0/Z, [X0]  // 10100101-00000000-11100000-00000000
// CHECK: ldnt1w  {z0.s}, p0/z, [x0] // encoding: [0x00,0xe0,0x00,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-00000000-11100000-00000000
ldnt1w  {z21.s}, p5/z, [x10, #5, mul vl]  // 10100101-00000101-11110101-01010101
// CHECK: ldnt1w  {z21.s}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xf5,0x05,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-00000101-11110101-01010101
LDNT1W  {Z21.S}, P5/Z, [X10, #5, MUL VL]  // 10100101-00000101-11110101-01010101
// CHECK: ldnt1w  {z21.s}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xf5,0x05,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-00000101-11110101-01010101
ldnt1w  {z23.s}, p3/z, [x13, #-8, mul vl]  // 10100101-00001000-11101101-10110111
// CHECK: ldnt1w  {z23.s}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xed,0x08,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-00001000-11101101-10110111
LDNT1W  {Z23.S}, P3/Z, [X13, #-8, MUL VL]  // 10100101-00001000-11101101-10110111
// CHECK: ldnt1w  {z23.s}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xed,0x08,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-00001000-11101101-10110111
ldnt1w  {z31.s}, p7/z, [sp, #-1, mul vl]  // 10100101-00001111-11111111-11111111
// CHECK: ldnt1w  {z31.s}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xff,0x0f,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-00001111-11111111-11111111
LDNT1W  {Z31.S}, P7/Z, [SP, #-1, MUL VL]  // 10100101-00001111-11111111-11111111
// CHECK: ldnt1w  {z31.s}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xff,0x0f,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-00001111-11111111-11111111
