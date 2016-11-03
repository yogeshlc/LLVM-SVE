// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
cpy     z23.s, p8/m, #0  // 00000101-10011000-01000000-00010111
// CHECK: mov     z23.s, p8/m, #0 // encoding: [0x17,0x40,0x98,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10011000-01000000-00010111
CPY     Z23.S, P8/M, #0  // 00000101-10011000-01000000-00010111
// CHECK: mov     z23.s, p8/m, #0 // encoding: [0x17,0x40,0x98,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10011000-01000000-00010111
cpy     z0.s, p0/m, #0  // 00000101-10010000-01000000-00000000
// CHECK: mov     z0.s, p0/m, #0 // encoding: [0x00,0x40,0x90,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10010000-01000000-00000000
CPY     Z0.S, P0/M, #0  // 00000101-10010000-01000000-00000000
// CHECK: mov     z0.s, p0/m, #0 // encoding: [0x00,0x40,0x90,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10010000-01000000-00000000
cpy     z21.s, p5/m, #-86  // 00000101-10010101-01010101-01010101
// CHECK: mov     z21.s, p5/m, #-86 // encoding: [0x55,0x55,0x95,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10010101-01010101-01010101
CPY     Z21.S, P5/M, #-86  // 00000101-10010101-01010101-01010101
// CHECK: mov     z21.s, p5/m, #-86 // encoding: [0x55,0x55,0x95,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10010101-01010101-01010101
cpy     z31.s, p15/m, #-1, lsl #8  // 00000101-10011111-01111111-11111111
// CHECK: mov     z31.s, p15/m, #-256 // encoding: [0xff,0x7f,0x9f,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10011111-01111111-11111111
CPY     Z31.S, P15/M, #-1, LSL #8  // 00000101-10011111-01111111-11111111
// CHECK: mov     z31.s, p15/m, #-256 // encoding: [0xff,0x7f,0x9f,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10011111-01111111-11111111
cpy     z31.s, p15/m, #-256  // 00000101-10011111-01111111-11111111
// CHECK: mov     z31.s, p15/m, #-256 // encoding: [0xff,0x7f,0x9f,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10011111-01111111-11111111
CPY     Z31.S, P15/M, #-256  // 00000101-10011111-01111111-11111111
// CHECK: mov     z31.s, p15/m, #-256 // encoding: [0xff,0x7f,0x9f,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10011111-01111111-11111111
cpy     z23.s, p8/m, #109, lsl #8  // 00000101-10011000-01101101-10110111
// CHECK: mov     z23.s, p8/m, #27904 // encoding: [0xb7,0x6d,0x98,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10011000-01101101-10110111
CPY     Z23.S, P8/M, #109, LSL #8  // 00000101-10011000-01101101-10110111
// CHECK: mov     z23.s, p8/m, #27904 // encoding: [0xb7,0x6d,0x98,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10011000-01101101-10110111
cpy     z23.s, p8/m, #27904  // 00000101-10011000-01101101-10110111
// CHECK: mov     z23.s, p8/m, #27904 // encoding: [0xb7,0x6d,0x98,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10011000-01101101-10110111
CPY     Z23.S, P8/M, #27904  // 00000101-10011000-01101101-10110111
// CHECK: mov     z23.s, p8/m, #27904 // encoding: [0xb7,0x6d,0x98,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10011000-01101101-10110111
cpy     z31.s, p15/m, #0  // 00000101-10011111-01000000-00011111
// CHECK: mov     z31.s, p15/m, #0 // encoding: [0x1f,0x40,0x9f,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10011111-01000000-00011111
CPY     Z31.S, P15/M, #0  // 00000101-10011111-01000000-00011111
// CHECK: mov     z31.s, p15/m, #0 // encoding: [0x1f,0x40,0x9f,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10011111-01000000-00011111
cpy     z21.s, p5/m, #0  // 00000101-10010101-01000000-00010101
// CHECK: mov     z21.s, p5/m, #0 // encoding: [0x15,0x40,0x95,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10010101-01000000-00010101
CPY     Z21.S, P5/M, #0  // 00000101-10010101-01000000-00010101
// CHECK: mov     z21.s, p5/m, #0 // encoding: [0x15,0x40,0x95,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10010101-01000000-00010101
