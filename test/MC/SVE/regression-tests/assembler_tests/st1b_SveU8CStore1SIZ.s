// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
st1b    {z31.b}, p7, [sp, #-1, mul vl]  // 11100100-00001111-11111111-11111111
// CHECK: st1b    {z31.b}, p7, [sp, #-1, mul vl] // encoding: [0xff,0xff,0x0f,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-00001111-11111111-11111111
ST1B    {Z31.B}, P7, [SP, #-1, MUL VL]  // 11100100-00001111-11111111-11111111
// CHECK: st1b    {z31.b}, p7, [sp, #-1, mul vl] // encoding: [0xff,0xff,0x0f,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-00001111-11111111-11111111
st1b    {z23.b}, p3, [x13, #-8, mul vl]  // 11100100-00001000-11101101-10110111
// CHECK: st1b    {z23.b}, p3, [x13, #-8, mul vl] // encoding: [0xb7,0xed,0x08,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-00001000-11101101-10110111
ST1B    {Z23.B}, P3, [X13, #-8, MUL VL]  // 11100100-00001000-11101101-10110111
// CHECK: st1b    {z23.b}, p3, [x13, #-8, mul vl] // encoding: [0xb7,0xed,0x08,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-00001000-11101101-10110111
st1b    {z21.b}, p5, [x10, #5, mul vl]  // 11100100-00000101-11110101-01010101
// CHECK: st1b    {z21.b}, p5, [x10, #5, mul vl] // encoding: [0x55,0xf5,0x05,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-00000101-11110101-01010101
ST1B    {Z21.B}, P5, [X10, #5, MUL VL]  // 11100100-00000101-11110101-01010101
// CHECK: st1b    {z21.b}, p5, [x10, #5, mul vl] // encoding: [0x55,0xf5,0x05,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-00000101-11110101-01010101
st1b    {z0.b}, p0, [x0]  // 11100100-00000000-11100000-00000000
// CHECK: st1b    {z0.b}, p0, [x0] // encoding: [0x00,0xe0,0x00,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-00000000-11100000-00000000
ST1B    {Z0.B}, P0, [X0]  // 11100100-00000000-11100000-00000000
// CHECK: st1b    {z0.b}, p0, [x0] // encoding: [0x00,0xe0,0x00,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-00000000-11100000-00000000
