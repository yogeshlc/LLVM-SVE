// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
st1w    {z0.s}, p0, [x0, z0.s, uxtw #2]  // 11100101-01100000-10000000-00000000
// CHECK: st1w    {z0.s}, p0, [x0, z0.s, uxtw #2] // encoding: [0x00,0x80,0x60,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-01100000-10000000-00000000
ST1W    {Z0.S}, P0, [X0, Z0.S, UXTW #2]  // 11100101-01100000-10000000-00000000
// CHECK: st1w    {z0.s}, p0, [x0, z0.s, uxtw #2] // encoding: [0x00,0x80,0x60,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-01100000-10000000-00000000
st1w    {z31.s}, p7, [sp, z31.s, uxtw #2]  // 11100101-01111111-10011111-11111111
// CHECK: st1w    {z31.s}, p7, [sp, z31.s, uxtw #2] // encoding: [0xff,0x9f,0x7f,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-01111111-10011111-11111111
ST1W    {Z31.S}, P7, [SP, Z31.S, UXTW #2]  // 11100101-01111111-10011111-11111111
// CHECK: st1w    {z31.s}, p7, [sp, z31.s, uxtw #2] // encoding: [0xff,0x9f,0x7f,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-01111111-10011111-11111111
st1w    {z23.s}, p3, [x13, z8.s, uxtw #2]  // 11100101-01101000-10001101-10110111
// CHECK: st1w    {z23.s}, p3, [x13, z8.s, uxtw #2] // encoding: [0xb7,0x8d,0x68,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-01101000-10001101-10110111
ST1W    {Z23.S}, P3, [X13, Z8.S, UXTW #2]  // 11100101-01101000-10001101-10110111
// CHECK: st1w    {z23.s}, p3, [x13, z8.s, uxtw #2] // encoding: [0xb7,0x8d,0x68,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-01101000-10001101-10110111
st1w    {z21.s}, p5, [x10, z21.s, uxtw #2]  // 11100101-01110101-10010101-01010101
// CHECK: st1w    {z21.s}, p5, [x10, z21.s, uxtw #2] // encoding: [0x55,0x95,0x75,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-01110101-10010101-01010101
ST1W    {Z21.S}, P5, [X10, Z21.S, UXTW #2]  // 11100101-01110101-10010101-01010101
// CHECK: st1w    {z21.s}, p5, [x10, z21.s, uxtw #2] // encoding: [0x55,0x95,0x75,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-01110101-10010101-01010101
