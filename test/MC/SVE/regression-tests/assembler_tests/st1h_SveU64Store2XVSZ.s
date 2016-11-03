// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
st1h    {z31.d}, p7, [sp, z31.d, sxtw]  // 11100100-10011111-11011111-11111111
// CHECK: st1h    {z31.d}, p7, [sp, z31.d, sxtw] // encoding: [0xff,0xdf,0x9f,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-10011111-11011111-11111111
ST1H    {Z31.D}, P7, [SP, Z31.D, SXTW]  // 11100100-10011111-11011111-11111111
// CHECK: st1h    {z31.d}, p7, [sp, z31.d, sxtw] // encoding: [0xff,0xdf,0x9f,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-10011111-11011111-11111111
st1h    {z0.d}, p0, [x0, z0.d, sxtw]  // 11100100-10000000-11000000-00000000
// CHECK: st1h    {z0.d}, p0, [x0, z0.d, sxtw] // encoding: [0x00,0xc0,0x80,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-10000000-11000000-00000000
ST1H    {Z0.D}, P0, [X0, Z0.D, SXTW]  // 11100100-10000000-11000000-00000000
// CHECK: st1h    {z0.d}, p0, [x0, z0.d, sxtw] // encoding: [0x00,0xc0,0x80,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-10000000-11000000-00000000
st1h    {z23.d}, p3, [x13, z8.d, sxtw]  // 11100100-10001000-11001101-10110111
// CHECK: st1h    {z23.d}, p3, [x13, z8.d, sxtw] // encoding: [0xb7,0xcd,0x88,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-10001000-11001101-10110111
ST1H    {Z23.D}, P3, [X13, Z8.D, SXTW]  // 11100100-10001000-11001101-10110111
// CHECK: st1h    {z23.d}, p3, [x13, z8.d, sxtw] // encoding: [0xb7,0xcd,0x88,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-10001000-11001101-10110111
st1h    {z21.d}, p5, [x10, z21.d, sxtw]  // 11100100-10010101-11010101-01010101
// CHECK: st1h    {z21.d}, p5, [x10, z21.d, sxtw] // encoding: [0x55,0xd5,0x95,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-10010101-11010101-01010101
ST1H    {Z21.D}, P5, [X10, Z21.D, SXTW]  // 11100100-10010101-11010101-01010101
// CHECK: st1h    {z21.d}, p5, [x10, z21.d, sxtw] // encoding: [0x55,0xd5,0x95,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-10010101-11010101-01010101
