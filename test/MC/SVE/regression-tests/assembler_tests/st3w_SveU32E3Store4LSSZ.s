// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
st3w    {z5.s, z6.s, z7.s}, p3, [x17, x16, lsl #2]  // 11100101-01010000-01101110-00100101
// CHECK: st3w    {z5.s, z6.s, z7.s}, p3, [x17, x16, lsl #2] // encoding: [0x25,0x6e,0x50,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-01010000-01101110-00100101
ST3W    {Z5.S, Z6.S, Z7.S}, P3, [X17, X16, LSL #2]  // 11100101-01010000-01101110-00100101
// CHECK: st3w    {z5.s, z6.s, z7.s}, p3, [x17, x16, lsl #2] // encoding: [0x25,0x6e,0x50,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-01010000-01101110-00100101
st3w    {z0.s, z1.s, z2.s}, p0, [x0, x0, lsl #2]  // 11100101-01000000-01100000-00000000
// CHECK: st3w    {z0.s, z1.s, z2.s}, p0, [x0, x0, lsl #2] // encoding: [0x00,0x60,0x40,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-01000000-01100000-00000000
ST3W    {Z0.S, Z1.S, Z2.S}, P0, [X0, X0, LSL #2]  // 11100101-01000000-01100000-00000000
// CHECK: st3w    {z0.s, z1.s, z2.s}, p0, [x0, x0, lsl #2] // encoding: [0x00,0x60,0x40,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-01000000-01100000-00000000
st3w    {z21.s, z22.s, z23.s}, p5, [x10, x21, lsl #2]  // 11100101-01010101-01110101-01010101
// CHECK: st3w    {z21.s, z22.s, z23.s}, p5, [x10, x21, lsl #2] // encoding: [0x55,0x75,0x55,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-01010101-01110101-01010101
ST3W    {Z21.S, Z22.S, Z23.S}, P5, [X10, X21, LSL #2]  // 11100101-01010101-01110101-01010101
// CHECK: st3w    {z21.s, z22.s, z23.s}, p5, [x10, x21, lsl #2] // encoding: [0x55,0x75,0x55,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-01010101-01110101-01010101
st3w    {z23.s, z24.s, z25.s}, p3, [x13, x8, lsl #2]  // 11100101-01001000-01101101-10110111
// CHECK: st3w    {z23.s, z24.s, z25.s}, p3, [x13, x8, lsl #2] // encoding: [0xb7,0x6d,0x48,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-01001000-01101101-10110111
ST3W    {Z23.S, Z24.S, Z25.S}, P3, [X13, X8, LSL #2]  // 11100101-01001000-01101101-10110111
// CHECK: st3w    {z23.s, z24.s, z25.s}, p3, [x13, x8, lsl #2] // encoding: [0xb7,0x6d,0x48,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-01001000-01101101-10110111
