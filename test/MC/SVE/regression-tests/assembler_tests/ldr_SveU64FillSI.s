// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ldr     z31, [sp, #-1, mul vl]  // 10000101-10111111-01011111-11111111
// CHECK: ldr     z31, [sp, #-1, mul vl] // encoding: [0xff,0x5f,0xbf,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-10111111-01011111-11111111
LDR     Z31, [SP, #-1, MUL VL]  // 10000101-10111111-01011111-11111111
// CHECK: ldr     z31, [sp, #-1, mul vl] // encoding: [0xff,0x5f,0xbf,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-10111111-01011111-11111111
ldr     z0, [x0]  // 10000101-10000000-01000000-00000000
// CHECK: ldr     z0, [x0] // encoding: [0x00,0x40,0x80,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-10000000-01000000-00000000
LDR     Z0, [X0]  // 10000101-10000000-01000000-00000000
// CHECK: ldr     z0, [x0] // encoding: [0x00,0x40,0x80,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-10000000-01000000-00000000
ldr     z21, [x10, #173, mul vl]  // 10000101-10010101-01010101-01010101
// CHECK: ldr     z21, [x10, #173, mul vl] // encoding: [0x55,0x55,0x95,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-10010101-01010101-01010101
LDR     Z21, [X10, #173, MUL VL]  // 10000101-10010101-01010101-01010101
// CHECK: ldr     z21, [x10, #173, mul vl] // encoding: [0x55,0x55,0x95,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-10010101-01010101-01010101
ldr     z23, [x13, #67, mul vl]  // 10000101-10001000-01001101-10110111
// CHECK: ldr     z23, [x13, #67, mul vl] // encoding: [0xb7,0x4d,0x88,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-10001000-01001101-10110111
LDR     Z23, [X13, #67, MUL VL]  // 10000101-10001000-01001101-10110111
// CHECK: ldr     z23, [x13, #67, mul vl] // encoding: [0xb7,0x4d,0x88,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-10001000-01001101-10110111
