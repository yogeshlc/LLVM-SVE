// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
st3h    {z0.h, z1.h, z2.h}, p0, [x0]  // 11100100-11010000-11100000-00000000
// CHECK: st3h    {z0.h, z1.h, z2.h}, p0, [x0] // encoding: [0x00,0xe0,0xd0,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11010000-11100000-00000000
ST3H    {Z0.H, Z1.H, Z2.H}, P0, [X0]  // 11100100-11010000-11100000-00000000
// CHECK: st3h    {z0.h, z1.h, z2.h}, p0, [x0] // encoding: [0x00,0xe0,0xd0,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11010000-11100000-00000000
st3h    {z31.h, z0.h, z1.h}, p7, [sp, #-3, mul vl]  // 11100100-11011111-11111111-11111111
// CHECK: st3h    {z31.h, z0.h, z1.h}, p7, [sp, #-3, mul vl] // encoding: [0xff,0xff,0xdf,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11011111-11111111-11111111
ST3H    {Z31.H, Z0.H, Z1.H}, P7, [SP, #-3, MUL VL]  // 11100100-11011111-11111111-11111111
// CHECK: st3h    {z31.h, z0.h, z1.h}, p7, [sp, #-3, mul vl] // encoding: [0xff,0xff,0xdf,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11011111-11111111-11111111
st3h    {z21.h, z22.h, z23.h}, p5, [x10, #15, mul vl]  // 11100100-11010101-11110101-01010101
// CHECK: st3h    {z21.h, z22.h, z23.h}, p5, [x10, #15, mul vl] // encoding: [0x55,0xf5,0xd5,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11010101-11110101-01010101
ST3H    {Z21.H, Z22.H, Z23.H}, P5, [X10, #15, MUL VL]  // 11100100-11010101-11110101-01010101
// CHECK: st3h    {z21.h, z22.h, z23.h}, p5, [x10, #15, mul vl] // encoding: [0x55,0xf5,0xd5,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11010101-11110101-01010101
st3h    {z23.h, z24.h, z25.h}, p3, [x13, #-24, mul vl]  // 11100100-11011000-11101101-10110111
// CHECK: st3h    {z23.h, z24.h, z25.h}, p3, [x13, #-24, mul vl] // encoding: [0xb7,0xed,0xd8,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11011000-11101101-10110111
ST3H    {Z23.H, Z24.H, Z25.H}, P3, [X13, #-24, MUL VL]  // 11100100-11011000-11101101-10110111
// CHECK: st3h    {z23.h, z24.h, z25.h}, p3, [x13, #-24, mul vl] // encoding: [0xb7,0xed,0xd8,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11011000-11101101-10110111
