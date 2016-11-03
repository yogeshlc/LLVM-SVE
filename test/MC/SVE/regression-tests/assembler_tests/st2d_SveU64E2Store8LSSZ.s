// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
st2d    {z23.d, z24.d}, p3, [x13, x8, lsl #3]  // 11100101-10101000-01101101-10110111
// CHECK: st2d    {z23.d, z24.d}, p3, [x13, x8, lsl #3] // encoding: [0xb7,0x6d,0xa8,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-10101000-01101101-10110111
ST2D    {Z23.D, Z24.D}, P3, [X13, X8, LSL #3]  // 11100101-10101000-01101101-10110111
// CHECK: st2d    {z23.d, z24.d}, p3, [x13, x8, lsl #3] // encoding: [0xb7,0x6d,0xa8,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-10101000-01101101-10110111
st2d    {z5.d, z6.d}, p3, [x17, x16, lsl #3]  // 11100101-10110000-01101110-00100101
// CHECK: st2d    {z5.d, z6.d}, p3, [x17, x16, lsl #3] // encoding: [0x25,0x6e,0xb0,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-10110000-01101110-00100101
ST2D    {Z5.D, Z6.D}, P3, [X17, X16, LSL #3]  // 11100101-10110000-01101110-00100101
// CHECK: st2d    {z5.d, z6.d}, p3, [x17, x16, lsl #3] // encoding: [0x25,0x6e,0xb0,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-10110000-01101110-00100101
st2d    {z21.d, z22.d}, p5, [x10, x21, lsl #3]  // 11100101-10110101-01110101-01010101
// CHECK: st2d    {z21.d, z22.d}, p5, [x10, x21, lsl #3] // encoding: [0x55,0x75,0xb5,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-10110101-01110101-01010101
ST2D    {Z21.D, Z22.D}, P5, [X10, X21, LSL #3]  // 11100101-10110101-01110101-01010101
// CHECK: st2d    {z21.d, z22.d}, p5, [x10, x21, lsl #3] // encoding: [0x55,0x75,0xb5,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-10110101-01110101-01010101
st2d    {z0.d, z1.d}, p0, [x0, x0, lsl #3]  // 11100101-10100000-01100000-00000000
// CHECK: st2d    {z0.d, z1.d}, p0, [x0, x0, lsl #3] // encoding: [0x00,0x60,0xa0,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-10100000-01100000-00000000
ST2D    {Z0.D, Z1.D}, P0, [X0, X0, LSL #3]  // 11100101-10100000-01100000-00000000
// CHECK: st2d    {z0.d, z1.d}, p0, [x0, x0, lsl #3] // encoding: [0x00,0x60,0xa0,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-10100000-01100000-00000000
