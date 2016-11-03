// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fmov    z31.d, p15/m, #0.0  // 00000101-11011111-01000000-00011111
// CHECK: mov     z31.d, p15/m, #0 // encoding: [0x1f,0x40,0xdf,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11011111-01000000-00011111
FMOV    Z31.D, P15/M, #0.0  // 00000101-11011111-01000000-00011111
// CHECK: mov     z31.d, p15/m, #0 // encoding: [0x1f,0x40,0xdf,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11011111-01000000-00011111
fmov    z23.d, p8/m, #0.0  // 00000101-11011000-01000000-00010111
// CHECK: mov     z23.d, p8/m, #0 // encoding: [0x17,0x40,0xd8,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11011000-01000000-00010111
FMOV    Z23.D, P8/M, #0.0  // 00000101-11011000-01000000-00010111
// CHECK: mov     z23.d, p8/m, #0 // encoding: [0x17,0x40,0xd8,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11011000-01000000-00010111
fmov    z21.d, p5/m, #0.0  // 00000101-11010101-01000000-00010101
// CHECK: mov     z21.d, p5/m, #0 // encoding: [0x15,0x40,0xd5,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11010101-01000000-00010101
FMOV    Z21.D, P5/M, #0.0  // 00000101-11010101-01000000-00010101
// CHECK: mov     z21.d, p5/m, #0 // encoding: [0x15,0x40,0xd5,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11010101-01000000-00010101
