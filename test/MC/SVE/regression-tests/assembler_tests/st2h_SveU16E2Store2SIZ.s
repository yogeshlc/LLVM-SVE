// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
st2h    {z0.h, z1.h}, p0, [x0]  // 11100100-10110000-11100000-00000000
// CHECK: st2h    {z0.h, z1.h}, p0, [x0] // encoding: [0x00,0xe0,0xb0,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-10110000-11100000-00000000
ST2H    {Z0.H, Z1.H}, P0, [X0]  // 11100100-10110000-11100000-00000000
// CHECK: st2h    {z0.h, z1.h}, p0, [x0] // encoding: [0x00,0xe0,0xb0,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-10110000-11100000-00000000
st2h    {z31.h, z0.h}, p7, [sp, #-2, mul vl]  // 11100100-10111111-11111111-11111111
// CHECK: st2h    {z31.h, z0.h}, p7, [sp, #-2, mul vl] // encoding: [0xff,0xff,0xbf,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-10111111-11111111-11111111
ST2H    {Z31.H, Z0.H}, P7, [SP, #-2, MUL VL]  // 11100100-10111111-11111111-11111111
// CHECK: st2h    {z31.h, z0.h}, p7, [sp, #-2, mul vl] // encoding: [0xff,0xff,0xbf,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-10111111-11111111-11111111
st2h    {z21.h, z22.h}, p5, [x10, #10, mul vl]  // 11100100-10110101-11110101-01010101
// CHECK: st2h    {z21.h, z22.h}, p5, [x10, #10, mul vl] // encoding: [0x55,0xf5,0xb5,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-10110101-11110101-01010101
ST2H    {Z21.H, Z22.H}, P5, [X10, #10, MUL VL]  // 11100100-10110101-11110101-01010101
// CHECK: st2h    {z21.h, z22.h}, p5, [x10, #10, mul vl] // encoding: [0x55,0xf5,0xb5,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-10110101-11110101-01010101
st2h    {z23.h, z24.h}, p3, [x13, #-16, mul vl]  // 11100100-10111000-11101101-10110111
// CHECK: st2h    {z23.h, z24.h}, p3, [x13, #-16, mul vl] // encoding: [0xb7,0xed,0xb8,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-10111000-11101101-10110111
ST2H    {Z23.H, Z24.H}, P3, [X13, #-16, MUL VL]  // 11100100-10111000-11101101-10110111
// CHECK: st2h    {z23.h, z24.h}, p3, [x13, #-16, mul vl] // encoding: [0xb7,0xed,0xb8,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-10111000-11101101-10110111
