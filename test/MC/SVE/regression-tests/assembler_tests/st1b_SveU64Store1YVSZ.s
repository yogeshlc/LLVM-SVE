// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
st1b    {z31.d}, p7, [sp, z31.d, uxtw]  // 11100100-00011111-10011111-11111111
// CHECK: st1b    {z31.d}, p7, [sp, z31.d, uxtw] // encoding: [0xff,0x9f,0x1f,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-00011111-10011111-11111111
ST1B    {Z31.D}, P7, [SP, Z31.D, UXTW]  // 11100100-00011111-10011111-11111111
// CHECK: st1b    {z31.d}, p7, [sp, z31.d, uxtw] // encoding: [0xff,0x9f,0x1f,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-00011111-10011111-11111111
st1b    {z0.d}, p0, [x0, z0.d, uxtw]  // 11100100-00000000-10000000-00000000
// CHECK: st1b    {z0.d}, p0, [x0, z0.d, uxtw] // encoding: [0x00,0x80,0x00,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-00000000-10000000-00000000
ST1B    {Z0.D}, P0, [X0, Z0.D, UXTW]  // 11100100-00000000-10000000-00000000
// CHECK: st1b    {z0.d}, p0, [x0, z0.d, uxtw] // encoding: [0x00,0x80,0x00,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-00000000-10000000-00000000
st1b    {z21.d}, p5, [x10, z21.d, uxtw]  // 11100100-00010101-10010101-01010101
// CHECK: st1b    {z21.d}, p5, [x10, z21.d, uxtw] // encoding: [0x55,0x95,0x15,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-00010101-10010101-01010101
ST1B    {Z21.D}, P5, [X10, Z21.D, UXTW]  // 11100100-00010101-10010101-01010101
// CHECK: st1b    {z21.d}, p5, [x10, z21.d, uxtw] // encoding: [0x55,0x95,0x15,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-00010101-10010101-01010101
st1b    {z23.d}, p3, [x13, z8.d, uxtw]  // 11100100-00001000-10001101-10110111
// CHECK: st1b    {z23.d}, p3, [x13, z8.d, uxtw] // encoding: [0xb7,0x8d,0x08,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-00001000-10001101-10110111
ST1B    {Z23.D}, P3, [X13, Z8.D, UXTW]  // 11100100-00001000-10001101-10110111
// CHECK: st1b    {z23.d}, p3, [x13, z8.d, uxtw] // encoding: [0xb7,0x8d,0x08,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-00001000-10001101-10110111
