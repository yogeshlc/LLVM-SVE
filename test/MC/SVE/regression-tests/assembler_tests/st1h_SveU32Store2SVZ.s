// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
st1h    {z23.s}, p3, [x13, z8.s, uxtw #1]  // 11100100-11101000-10001101-10110111
// CHECK: st1h    {z23.s}, p3, [x13, z8.s, uxtw #1] // encoding: [0xb7,0x8d,0xe8,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11101000-10001101-10110111
ST1H    {Z23.S}, P3, [X13, Z8.S, UXTW #1]  // 11100100-11101000-10001101-10110111
// CHECK: st1h    {z23.s}, p3, [x13, z8.s, uxtw #1] // encoding: [0xb7,0x8d,0xe8,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11101000-10001101-10110111
st1h    {z31.s}, p7, [sp, z31.s, uxtw #1]  // 11100100-11111111-10011111-11111111
// CHECK: st1h    {z31.s}, p7, [sp, z31.s, uxtw #1] // encoding: [0xff,0x9f,0xff,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11111111-10011111-11111111
ST1H    {Z31.S}, P7, [SP, Z31.S, UXTW #1]  // 11100100-11111111-10011111-11111111
// CHECK: st1h    {z31.s}, p7, [sp, z31.s, uxtw #1] // encoding: [0xff,0x9f,0xff,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11111111-10011111-11111111
st1h    {z21.s}, p5, [x10, z21.s, uxtw #1]  // 11100100-11110101-10010101-01010101
// CHECK: st1h    {z21.s}, p5, [x10, z21.s, uxtw #1] // encoding: [0x55,0x95,0xf5,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11110101-10010101-01010101
ST1H    {Z21.S}, P5, [X10, Z21.S, UXTW #1]  // 11100100-11110101-10010101-01010101
// CHECK: st1h    {z21.s}, p5, [x10, z21.s, uxtw #1] // encoding: [0x55,0x95,0xf5,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11110101-10010101-01010101
st1h    {z0.s}, p0, [x0, z0.s, uxtw #1]  // 11100100-11100000-10000000-00000000
// CHECK: st1h    {z0.s}, p0, [x0, z0.s, uxtw #1] // encoding: [0x00,0x80,0xe0,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11100000-10000000-00000000
ST1H    {Z0.S}, P0, [X0, Z0.S, UXTW #1]  // 11100100-11100000-10000000-00000000
// CHECK: st1h    {z0.s}, p0, [x0, z0.s, uxtw #1] // encoding: [0x00,0x80,0xe0,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11100000-10000000-00000000
