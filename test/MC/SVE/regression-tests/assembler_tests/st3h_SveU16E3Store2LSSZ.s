// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
st3h    {z5.h, z6.h, z7.h}, p3, [x17, x16, lsl #1]  // 11100100-11010000-01101110-00100101
// CHECK: st3h    {z5.h, z6.h, z7.h}, p3, [x17, x16, lsl #1] // encoding: [0x25,0x6e,0xd0,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11010000-01101110-00100101
ST3H    {Z5.H, Z6.H, Z7.H}, P3, [X17, X16, LSL #1]  // 11100100-11010000-01101110-00100101
// CHECK: st3h    {z5.h, z6.h, z7.h}, p3, [x17, x16, lsl #1] // encoding: [0x25,0x6e,0xd0,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11010000-01101110-00100101
st3h    {z23.h, z24.h, z25.h}, p3, [x13, x8, lsl #1]  // 11100100-11001000-01101101-10110111
// CHECK: st3h    {z23.h, z24.h, z25.h}, p3, [x13, x8, lsl #1] // encoding: [0xb7,0x6d,0xc8,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11001000-01101101-10110111
ST3H    {Z23.H, Z24.H, Z25.H}, P3, [X13, X8, LSL #1]  // 11100100-11001000-01101101-10110111
// CHECK: st3h    {z23.h, z24.h, z25.h}, p3, [x13, x8, lsl #1] // encoding: [0xb7,0x6d,0xc8,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11001000-01101101-10110111
st3h    {z0.h, z1.h, z2.h}, p0, [x0, x0, lsl #1]  // 11100100-11000000-01100000-00000000
// CHECK: st3h    {z0.h, z1.h, z2.h}, p0, [x0, x0, lsl #1] // encoding: [0x00,0x60,0xc0,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11000000-01100000-00000000
ST3H    {Z0.H, Z1.H, Z2.H}, P0, [X0, X0, LSL #1]  // 11100100-11000000-01100000-00000000
// CHECK: st3h    {z0.h, z1.h, z2.h}, p0, [x0, x0, lsl #1] // encoding: [0x00,0x60,0xc0,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11000000-01100000-00000000
st3h    {z21.h, z22.h, z23.h}, p5, [x10, x21, lsl #1]  // 11100100-11010101-01110101-01010101
// CHECK: st3h    {z21.h, z22.h, z23.h}, p5, [x10, x21, lsl #1] // encoding: [0x55,0x75,0xd5,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11010101-01110101-01010101
ST3H    {Z21.H, Z22.H, Z23.H}, P5, [X10, X21, LSL #1]  // 11100100-11010101-01110101-01010101
// CHECK: st3h    {z21.h, z22.h, z23.h}, p5, [x10, x21, lsl #1] // encoding: [0x55,0x75,0xd5,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11010101-01110101-01010101
