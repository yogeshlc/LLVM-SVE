// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
st1d    {z21.d}, p5, [x10, z21.d, uxtw]  // 11100101-10010101-10010101-01010101
// CHECK: st1d    {z21.d}, p5, [x10, z21.d, uxtw] // encoding: [0x55,0x95,0x95,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-10010101-10010101-01010101
ST1D    {Z21.D}, P5, [X10, Z21.D, UXTW]  // 11100101-10010101-10010101-01010101
// CHECK: st1d    {z21.d}, p5, [x10, z21.d, uxtw] // encoding: [0x55,0x95,0x95,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-10010101-10010101-01010101
st1d    {z31.d}, p7, [sp, z31.d, uxtw]  // 11100101-10011111-10011111-11111111
// CHECK: st1d    {z31.d}, p7, [sp, z31.d, uxtw] // encoding: [0xff,0x9f,0x9f,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-10011111-10011111-11111111
ST1D    {Z31.D}, P7, [SP, Z31.D, UXTW]  // 11100101-10011111-10011111-11111111
// CHECK: st1d    {z31.d}, p7, [sp, z31.d, uxtw] // encoding: [0xff,0x9f,0x9f,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-10011111-10011111-11111111
st1d    {z23.d}, p3, [x13, z8.d, uxtw]  // 11100101-10001000-10001101-10110111
// CHECK: st1d    {z23.d}, p3, [x13, z8.d, uxtw] // encoding: [0xb7,0x8d,0x88,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-10001000-10001101-10110111
ST1D    {Z23.D}, P3, [X13, Z8.D, UXTW]  // 11100101-10001000-10001101-10110111
// CHECK: st1d    {z23.d}, p3, [x13, z8.d, uxtw] // encoding: [0xb7,0x8d,0x88,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-10001000-10001101-10110111
st1d    {z0.d}, p0, [x0, z0.d, uxtw]  // 11100101-10000000-10000000-00000000
// CHECK: st1d    {z0.d}, p0, [x0, z0.d, uxtw] // encoding: [0x00,0x80,0x80,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-10000000-10000000-00000000
ST1D    {Z0.D}, P0, [X0, Z0.D, UXTW]  // 11100101-10000000-10000000-00000000
// CHECK: st1d    {z0.d}, p0, [x0, z0.d, uxtw] // encoding: [0x00,0x80,0x80,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-10000000-10000000-00000000
