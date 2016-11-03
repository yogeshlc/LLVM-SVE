// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
st1w    {z21.s}, p5, [x10, z21.s, sxtw]  // 11100101-01010101-11010101-01010101
// CHECK: st1w    {z21.s}, p5, [x10, z21.s, sxtw] // encoding: [0x55,0xd5,0x55,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-01010101-11010101-01010101
ST1W    {Z21.S}, P5, [X10, Z21.S, SXTW]  // 11100101-01010101-11010101-01010101
// CHECK: st1w    {z21.s}, p5, [x10, z21.s, sxtw] // encoding: [0x55,0xd5,0x55,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-01010101-11010101-01010101
st1w    {z0.s}, p0, [x0, z0.s, sxtw]  // 11100101-01000000-11000000-00000000
// CHECK: st1w    {z0.s}, p0, [x0, z0.s, sxtw] // encoding: [0x00,0xc0,0x40,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-01000000-11000000-00000000
ST1W    {Z0.S}, P0, [X0, Z0.S, SXTW]  // 11100101-01000000-11000000-00000000
// CHECK: st1w    {z0.s}, p0, [x0, z0.s, sxtw] // encoding: [0x00,0xc0,0x40,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-01000000-11000000-00000000
st1w    {z31.s}, p7, [sp, z31.s, sxtw]  // 11100101-01011111-11011111-11111111
// CHECK: st1w    {z31.s}, p7, [sp, z31.s, sxtw] // encoding: [0xff,0xdf,0x5f,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-01011111-11011111-11111111
ST1W    {Z31.S}, P7, [SP, Z31.S, SXTW]  // 11100101-01011111-11011111-11111111
// CHECK: st1w    {z31.s}, p7, [sp, z31.s, sxtw] // encoding: [0xff,0xdf,0x5f,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-01011111-11011111-11111111
st1w    {z23.s}, p3, [x13, z8.s, sxtw]  // 11100101-01001000-11001101-10110111
// CHECK: st1w    {z23.s}, p3, [x13, z8.s, sxtw] // encoding: [0xb7,0xcd,0x48,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-01001000-11001101-10110111
ST1W    {Z23.S}, P3, [X13, Z8.S, SXTW]  // 11100101-01001000-11001101-10110111
// CHECK: st1w    {z23.s}, p3, [x13, z8.s, sxtw] // encoding: [0xb7,0xcd,0x48,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-01001000-11001101-10110111
