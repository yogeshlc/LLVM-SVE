// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
st3d    {z21.d, z22.d, z23.d}, p5, [x10, x21, lsl #3]  // 11100101-11010101-01110101-01010101
// CHECK: st3d    {z21.d, z22.d, z23.d}, p5, [x10, x21, lsl #3] // encoding: [0x55,0x75,0xd5,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-11010101-01110101-01010101
ST3D    {Z21.D, Z22.D, Z23.D}, P5, [X10, X21, LSL #3]  // 11100101-11010101-01110101-01010101
// CHECK: st3d    {z21.d, z22.d, z23.d}, p5, [x10, x21, lsl #3] // encoding: [0x55,0x75,0xd5,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-11010101-01110101-01010101
st3d    {z0.d, z1.d, z2.d}, p0, [x0, x0, lsl #3]  // 11100101-11000000-01100000-00000000
// CHECK: st3d    {z0.d, z1.d, z2.d}, p0, [x0, x0, lsl #3] // encoding: [0x00,0x60,0xc0,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-11000000-01100000-00000000
ST3D    {Z0.D, Z1.D, Z2.D}, P0, [X0, X0, LSL #3]  // 11100101-11000000-01100000-00000000
// CHECK: st3d    {z0.d, z1.d, z2.d}, p0, [x0, x0, lsl #3] // encoding: [0x00,0x60,0xc0,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-11000000-01100000-00000000
st3d    {z23.d, z24.d, z25.d}, p3, [x13, x8, lsl #3]  // 11100101-11001000-01101101-10110111
// CHECK: st3d    {z23.d, z24.d, z25.d}, p3, [x13, x8, lsl #3] // encoding: [0xb7,0x6d,0xc8,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-11001000-01101101-10110111
ST3D    {Z23.D, Z24.D, Z25.D}, P3, [X13, X8, LSL #3]  // 11100101-11001000-01101101-10110111
// CHECK: st3d    {z23.d, z24.d, z25.d}, p3, [x13, x8, lsl #3] // encoding: [0xb7,0x6d,0xc8,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-11001000-01101101-10110111
st3d    {z5.d, z6.d, z7.d}, p3, [x17, x16, lsl #3]  // 11100101-11010000-01101110-00100101
// CHECK: st3d    {z5.d, z6.d, z7.d}, p3, [x17, x16, lsl #3] // encoding: [0x25,0x6e,0xd0,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-11010000-01101110-00100101
ST3D    {Z5.D, Z6.D, Z7.D}, P3, [X17, X16, LSL #3]  // 11100101-11010000-01101110-00100101
// CHECK: st3d    {z5.d, z6.d, z7.d}, p3, [x17, x16, lsl #3] // encoding: [0x25,0x6e,0xd0,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-11010000-01101110-00100101
