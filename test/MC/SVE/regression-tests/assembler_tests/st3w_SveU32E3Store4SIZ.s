// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
st3w    {z23.s, z24.s, z25.s}, p3, [x13, #-24, mul vl]  // 11100101-01011000-11101101-10110111
// CHECK: st3w    {z23.s, z24.s, z25.s}, p3, [x13, #-24, mul vl] // encoding: [0xb7,0xed,0x58,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-01011000-11101101-10110111
ST3W    {Z23.S, Z24.S, Z25.S}, P3, [X13, #-24, MUL VL]  // 11100101-01011000-11101101-10110111
// CHECK: st3w    {z23.s, z24.s, z25.s}, p3, [x13, #-24, mul vl] // encoding: [0xb7,0xed,0x58,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-01011000-11101101-10110111
st3w    {z21.s, z22.s, z23.s}, p5, [x10, #15, mul vl]  // 11100101-01010101-11110101-01010101
// CHECK: st3w    {z21.s, z22.s, z23.s}, p5, [x10, #15, mul vl] // encoding: [0x55,0xf5,0x55,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-01010101-11110101-01010101
ST3W    {Z21.S, Z22.S, Z23.S}, P5, [X10, #15, MUL VL]  // 11100101-01010101-11110101-01010101
// CHECK: st3w    {z21.s, z22.s, z23.s}, p5, [x10, #15, mul vl] // encoding: [0x55,0xf5,0x55,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-01010101-11110101-01010101
st3w    {z0.s, z1.s, z2.s}, p0, [x0]  // 11100101-01010000-11100000-00000000
// CHECK: st3w    {z0.s, z1.s, z2.s}, p0, [x0] // encoding: [0x00,0xe0,0x50,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-01010000-11100000-00000000
ST3W    {Z0.S, Z1.S, Z2.S}, P0, [X0]  // 11100101-01010000-11100000-00000000
// CHECK: st3w    {z0.s, z1.s, z2.s}, p0, [x0] // encoding: [0x00,0xe0,0x50,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-01010000-11100000-00000000
st3w    {z31.s, z0.s, z1.s}, p7, [sp, #-3, mul vl]  // 11100101-01011111-11111111-11111111
// CHECK: st3w    {z31.s, z0.s, z1.s}, p7, [sp, #-3, mul vl] // encoding: [0xff,0xff,0x5f,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-01011111-11111111-11111111
ST3W    {Z31.S, Z0.S, Z1.S}, P7, [SP, #-3, MUL VL]  // 11100101-01011111-11111111-11111111
// CHECK: st3w    {z31.s, z0.s, z1.s}, p7, [sp, #-3, mul vl] // encoding: [0xff,0xff,0x5f,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-01011111-11111111-11111111
