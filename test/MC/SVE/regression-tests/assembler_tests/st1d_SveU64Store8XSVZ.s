// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
st1d    {z31.d}, p7, [sp, z31.d, sxtw #3]  // 11100101-10111111-11011111-11111111
// CHECK: st1d    {z31.d}, p7, [sp, z31.d, sxtw #3] // encoding: [0xff,0xdf,0xbf,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-10111111-11011111-11111111
ST1D    {Z31.D}, P7, [SP, Z31.D, SXTW #3]  // 11100101-10111111-11011111-11111111
// CHECK: st1d    {z31.d}, p7, [sp, z31.d, sxtw #3] // encoding: [0xff,0xdf,0xbf,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-10111111-11011111-11111111
st1d    {z21.d}, p5, [x10, z21.d, sxtw #3]  // 11100101-10110101-11010101-01010101
// CHECK: st1d    {z21.d}, p5, [x10, z21.d, sxtw #3] // encoding: [0x55,0xd5,0xb5,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-10110101-11010101-01010101
ST1D    {Z21.D}, P5, [X10, Z21.D, SXTW #3]  // 11100101-10110101-11010101-01010101
// CHECK: st1d    {z21.d}, p5, [x10, z21.d, sxtw #3] // encoding: [0x55,0xd5,0xb5,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-10110101-11010101-01010101
st1d    {z0.d}, p0, [x0, z0.d, sxtw #3]  // 11100101-10100000-11000000-00000000
// CHECK: st1d    {z0.d}, p0, [x0, z0.d, sxtw #3] // encoding: [0x00,0xc0,0xa0,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-10100000-11000000-00000000
ST1D    {Z0.D}, P0, [X0, Z0.D, SXTW #3]  // 11100101-10100000-11000000-00000000
// CHECK: st1d    {z0.d}, p0, [x0, z0.d, sxtw #3] // encoding: [0x00,0xc0,0xa0,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-10100000-11000000-00000000
st1d    {z23.d}, p3, [x13, z8.d, sxtw #3]  // 11100101-10101000-11001101-10110111
// CHECK: st1d    {z23.d}, p3, [x13, z8.d, sxtw #3] // encoding: [0xb7,0xcd,0xa8,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-10101000-11001101-10110111
ST1D    {Z23.D}, P3, [X13, Z8.D, SXTW #3]  // 11100101-10101000-11001101-10110111
// CHECK: st1d    {z23.d}, p3, [x13, z8.d, sxtw #3] // encoding: [0xb7,0xcd,0xa8,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-10101000-11001101-10110111
