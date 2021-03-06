// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
cpy     z5.b, p0/m, #113  // 00000101-00010000-01001110-00100101
// CHECK: mov     z5.b, p0/m, #113 // encoding: [0x25,0x4e,0x10,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00010000-01001110-00100101
CPY     Z5.B, P0/M, #113  // 00000101-00010000-01001110-00100101
// CHECK: mov     z5.b, p0/m, #113 // encoding: [0x25,0x4e,0x10,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00010000-01001110-00100101
cpy     z21.b, p5/m, #-86  // 00000101-00010101-01010101-01010101
// CHECK: mov     z21.b, p5/m, #-86 // encoding: [0x55,0x55,0x15,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00010101-01010101-01010101
CPY     Z21.B, P5/M, #-86  // 00000101-00010101-01010101-01010101
// CHECK: mov     z21.b, p5/m, #-86 // encoding: [0x55,0x55,0x15,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00010101-01010101-01010101
cpy     z1.b, p14/m, #33  // 00000101-00011110-01000100-00100001
// CHECK: mov     z1.b, p14/m, #33 // encoding: [0x21,0x44,0x1e,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00011110-01000100-00100001
CPY     Z1.B, P14/M, #33  // 00000101-00011110-01000100-00100001
// CHECK: mov     z1.b, p14/m, #33 // encoding: [0x21,0x44,0x1e,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00011110-01000100-00100001
cpy     z0.b, p0/m, #0  // 00000101-00010000-01000000-00000000
// CHECK: mov     z0.b, p0/m, #0 // encoding: [0x00,0x40,0x10,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00010000-01000000-00000000
CPY     Z0.B, P0/M, #0  // 00000101-00010000-01000000-00000000
// CHECK: mov     z0.b, p0/m, #0 // encoding: [0x00,0x40,0x10,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00010000-01000000-00000000
