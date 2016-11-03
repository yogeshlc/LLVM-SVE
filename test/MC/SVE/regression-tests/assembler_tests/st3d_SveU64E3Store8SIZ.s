// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
st3d    {z31.d, z0.d, z1.d}, p7, [sp, #-3, mul vl]  // 11100101-11011111-11111111-11111111
// CHECK: st3d    {z31.d, z0.d, z1.d}, p7, [sp, #-3, mul vl] // encoding: [0xff,0xff,0xdf,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-11011111-11111111-11111111
ST3D    {Z31.D, Z0.D, Z1.D}, P7, [SP, #-3, MUL VL]  // 11100101-11011111-11111111-11111111
// CHECK: st3d    {z31.d, z0.d, z1.d}, p7, [sp, #-3, mul vl] // encoding: [0xff,0xff,0xdf,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-11011111-11111111-11111111
st3d    {z23.d, z24.d, z25.d}, p3, [x13, #-24, mul vl]  // 11100101-11011000-11101101-10110111
// CHECK: st3d    {z23.d, z24.d, z25.d}, p3, [x13, #-24, mul vl] // encoding: [0xb7,0xed,0xd8,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-11011000-11101101-10110111
ST3D    {Z23.D, Z24.D, Z25.D}, P3, [X13, #-24, MUL VL]  // 11100101-11011000-11101101-10110111
// CHECK: st3d    {z23.d, z24.d, z25.d}, p3, [x13, #-24, mul vl] // encoding: [0xb7,0xed,0xd8,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-11011000-11101101-10110111
st3d    {z21.d, z22.d, z23.d}, p5, [x10, #15, mul vl]  // 11100101-11010101-11110101-01010101
// CHECK: st3d    {z21.d, z22.d, z23.d}, p5, [x10, #15, mul vl] // encoding: [0x55,0xf5,0xd5,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-11010101-11110101-01010101
ST3D    {Z21.D, Z22.D, Z23.D}, P5, [X10, #15, MUL VL]  // 11100101-11010101-11110101-01010101
// CHECK: st3d    {z21.d, z22.d, z23.d}, p5, [x10, #15, mul vl] // encoding: [0x55,0xf5,0xd5,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-11010101-11110101-01010101
st3d    {z0.d, z1.d, z2.d}, p0, [x0]  // 11100101-11010000-11100000-00000000
// CHECK: st3d    {z0.d, z1.d, z2.d}, p0, [x0] // encoding: [0x00,0xe0,0xd0,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-11010000-11100000-00000000
ST3D    {Z0.D, Z1.D, Z2.D}, P0, [X0]  // 11100101-11010000-11100000-00000000
// CHECK: st3d    {z0.d, z1.d, z2.d}, p0, [x0] // encoding: [0x00,0xe0,0xd0,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-11010000-11100000-00000000
