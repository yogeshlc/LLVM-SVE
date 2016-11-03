// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fmov    z23.s, p8/m, #0.0  // 00000101-10011000-01000000-00010111
// CHECK: mov     z23.s, p8/m, #0 // encoding: [0x17,0x40,0x98,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10011000-01000000-00010111
FMOV    Z23.S, P8/M, #0.0  // 00000101-10011000-01000000-00010111
// CHECK: mov     z23.s, p8/m, #0 // encoding: [0x17,0x40,0x98,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10011000-01000000-00010111
fmov    z31.s, p15/m, #0.0  // 00000101-10011111-01000000-00011111
// CHECK: mov     z31.s, p15/m, #0 // encoding: [0x1f,0x40,0x9f,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10011111-01000000-00011111
FMOV    Z31.S, P15/M, #0.0  // 00000101-10011111-01000000-00011111
// CHECK: mov     z31.s, p15/m, #0 // encoding: [0x1f,0x40,0x9f,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10011111-01000000-00011111
fmov    z21.s, p5/m, #0.0  // 00000101-10010101-01000000-00010101
// CHECK: mov     z21.s, p5/m, #0 // encoding: [0x15,0x40,0x95,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10010101-01000000-00010101
FMOV    Z21.S, P5/M, #0.0  // 00000101-10010101-01000000-00010101
// CHECK: mov     z21.s, p5/m, #0 // encoding: [0x15,0x40,0x95,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10010101-01000000-00010101
