// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
cpy     z21.h, p5/z, #-86  // 00000101-01010101-00010101-01010101
// CHECK: mov     z21.h, p5/z, #-86 // encoding: [0x55,0x15,0x55,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01010101-00010101-01010101
CPY     Z21.H, P5/Z, #-86  // 00000101-01010101-00010101-01010101
// CHECK: mov     z21.h, p5/z, #-86 // encoding: [0x55,0x15,0x55,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01010101-00010101-01010101
cpy     z31.h, p15/z, #-1, lsl #8  // 00000101-01011111-00111111-11111111
// CHECK: mov     z31.h, p15/z, #-256 // encoding: [0xff,0x3f,0x5f,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01011111-00111111-11111111
CPY     Z31.H, P15/Z, #-1, LSL #8  // 00000101-01011111-00111111-11111111
// CHECK: mov     z31.h, p15/z, #-256 // encoding: [0xff,0x3f,0x5f,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01011111-00111111-11111111
cpy     z31.h, p15/z, #-256  // 00000101-01011111-00111111-11111111
// CHECK: mov     z31.h, p15/z, #-256 // encoding: [0xff,0x3f,0x5f,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01011111-00111111-11111111
CPY     Z31.H, P15/Z, #-256  // 00000101-01011111-00111111-11111111
// CHECK: mov     z31.h, p15/z, #-256 // encoding: [0xff,0x3f,0x5f,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01011111-00111111-11111111
cpy     z0.h, p0/z, #0  // 00000101-01010000-00000000-00000000
// CHECK: mov     z0.h, p0/z, #0 // encoding: [0x00,0x00,0x50,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01010000-00000000-00000000
CPY     Z0.H, P0/Z, #0  // 00000101-01010000-00000000-00000000
// CHECK: mov     z0.h, p0/z, #0 // encoding: [0x00,0x00,0x50,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01010000-00000000-00000000
cpy     z23.h, p8/z, #109, lsl #8  // 00000101-01011000-00101101-10110111
// CHECK: mov     z23.h, p8/z, #27904 // encoding: [0xb7,0x2d,0x58,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01011000-00101101-10110111
CPY     Z23.H, P8/Z, #109, LSL #8  // 00000101-01011000-00101101-10110111
// CHECK: mov     z23.h, p8/z, #27904 // encoding: [0xb7,0x2d,0x58,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01011000-00101101-10110111
cpy     z23.h, p8/z, #27904  // 00000101-01011000-00101101-10110111
// CHECK: mov     z23.h, p8/z, #27904 // encoding: [0xb7,0x2d,0x58,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01011000-00101101-10110111
CPY     Z23.H, P8/Z, #27904  // 00000101-01011000-00101101-10110111
// CHECK: mov     z23.h, p8/z, #27904 // encoding: [0xb7,0x2d,0x58,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01011000-00101101-10110111
