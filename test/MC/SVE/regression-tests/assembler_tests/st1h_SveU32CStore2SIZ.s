// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
st1h    {z31.s}, p7, [sp, #-1, mul vl]  // 11100100-11001111-11111111-11111111
// CHECK: st1h    {z31.s}, p7, [sp, #-1, mul vl] // encoding: [0xff,0xff,0xcf,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11001111-11111111-11111111
ST1H    {Z31.S}, P7, [SP, #-1, MUL VL]  // 11100100-11001111-11111111-11111111
// CHECK: st1h    {z31.s}, p7, [sp, #-1, mul vl] // encoding: [0xff,0xff,0xcf,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11001111-11111111-11111111
st1h    {z21.s}, p5, [x10, #5, mul vl]  // 11100100-11000101-11110101-01010101
// CHECK: st1h    {z21.s}, p5, [x10, #5, mul vl] // encoding: [0x55,0xf5,0xc5,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11000101-11110101-01010101
ST1H    {Z21.S}, P5, [X10, #5, MUL VL]  // 11100100-11000101-11110101-01010101
// CHECK: st1h    {z21.s}, p5, [x10, #5, mul vl] // encoding: [0x55,0xf5,0xc5,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11000101-11110101-01010101
st1h    {z23.s}, p3, [x13, #-8, mul vl]  // 11100100-11001000-11101101-10110111
// CHECK: st1h    {z23.s}, p3, [x13, #-8, mul vl] // encoding: [0xb7,0xed,0xc8,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11001000-11101101-10110111
ST1H    {Z23.S}, P3, [X13, #-8, MUL VL]  // 11100100-11001000-11101101-10110111
// CHECK: st1h    {z23.s}, p3, [x13, #-8, mul vl] // encoding: [0xb7,0xed,0xc8,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11001000-11101101-10110111
st1h    {z0.s}, p0, [x0]  // 11100100-11000000-11100000-00000000
// CHECK: st1h    {z0.s}, p0, [x0] // encoding: [0x00,0xe0,0xc0,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11000000-11100000-00000000
ST1H    {Z0.S}, P0, [X0]  // 11100100-11000000-11100000-00000000
// CHECK: st1h    {z0.s}, p0, [x0] // encoding: [0x00,0xe0,0xc0,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11000000-11100000-00000000
