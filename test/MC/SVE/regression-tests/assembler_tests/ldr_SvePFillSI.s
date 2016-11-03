// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ldr     p15, [sp, #-1, mul vl]  // 10000101-10111111-00011111-11101111
// CHECK: ldr     p15, [sp, #-1, mul vl] // encoding: [0xef,0x1f,0xbf,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-10111111-00011111-11101111
LDR     P15, [SP, #-1, MUL VL]  // 10000101-10111111-00011111-11101111
// CHECK: ldr     p15, [sp, #-1, mul vl] // encoding: [0xef,0x1f,0xbf,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-10111111-00011111-11101111
ldr     p7, [x13, #67, mul vl]  // 10000101-10001000-00001101-10100111
// CHECK: ldr     p7, [x13, #67, mul vl] // encoding: [0xa7,0x0d,0x88,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-10001000-00001101-10100111
LDR     P7, [X13, #67, MUL VL]  // 10000101-10001000-00001101-10100111
// CHECK: ldr     p7, [x13, #67, mul vl] // encoding: [0xa7,0x0d,0x88,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-10001000-00001101-10100111
ldr     p5, [x10, #173, mul vl]  // 10000101-10010101-00010101-01000101
// CHECK: ldr     p5, [x10, #173, mul vl] // encoding: [0x45,0x15,0x95,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-10010101-00010101-01000101
LDR     P5, [X10, #173, MUL VL]  // 10000101-10010101-00010101-01000101
// CHECK: ldr     p5, [x10, #173, mul vl] // encoding: [0x45,0x15,0x95,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-10010101-00010101-01000101
ldr     p0, [x0]  // 10000101-10000000-00000000-00000000
// CHECK: ldr     p0, [x0] // encoding: [0x00,0x00,0x80,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-10000000-00000000-00000000
LDR     P0, [X0]  // 10000101-10000000-00000000-00000000
// CHECK: ldr     p0, [x0] // encoding: [0x00,0x00,0x80,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-10000000-00000000-00000000
