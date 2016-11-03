// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
dup     z21.h, #-86  // 00100101-01111000-11010101-01010101
// CHECK: mov     z21.h, #-86 // encoding: [0x55,0xd5,0x78,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01111000-11010101-01010101
DUP     Z21.H, #-86  // 00100101-01111000-11010101-01010101
// CHECK: mov     z21.h, #-86 // encoding: [0x55,0xd5,0x78,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01111000-11010101-01010101
dup     z31.h, #-1, lsl #8  // 00100101-01111000-11111111-11111111
// CHECK: mov     z31.h, #-256 // encoding: [0xff,0xff,0x78,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01111000-11111111-11111111
DUP     Z31.H, #-1, LSL #8  // 00100101-01111000-11111111-11111111
// CHECK: mov     z31.h, #-256 // encoding: [0xff,0xff,0x78,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01111000-11111111-11111111
dup     z31.h, #-256  // 00100101-01111000-11111111-11111111
// CHECK: mov     z31.h, #-256 // encoding: [0xff,0xff,0x78,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01111000-11111111-11111111
DUP     Z31.H, #-256  // 00100101-01111000-11111111-11111111
// CHECK: mov     z31.h, #-256 // encoding: [0xff,0xff,0x78,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01111000-11111111-11111111
dup     z0.h, #0  // 00100101-01111000-11000000-00000000
// CHECK: mov     z0.h, #0 // encoding: [0x00,0xc0,0x78,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01111000-11000000-00000000
DUP     Z0.H, #0  // 00100101-01111000-11000000-00000000
// CHECK: mov     z0.h, #0 // encoding: [0x00,0xc0,0x78,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01111000-11000000-00000000
dup     z23.h, #109, lsl #8  // 00100101-01111000-11101101-10110111
// CHECK: mov     z23.h, #27904 // encoding: [0xb7,0xed,0x78,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01111000-11101101-10110111
DUP     Z23.H, #109, LSL #8  // 00100101-01111000-11101101-10110111
// CHECK: mov     z23.h, #27904 // encoding: [0xb7,0xed,0x78,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01111000-11101101-10110111
dup     z23.h, #27904  // 00100101-01111000-11101101-10110111
// CHECK: mov     z23.h, #27904 // encoding: [0xb7,0xed,0x78,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01111000-11101101-10110111
DUP     Z23.H, #27904  // 00100101-01111000-11101101-10110111
// CHECK: mov     z23.h, #27904 // encoding: [0xb7,0xed,0x78,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01111000-11101101-10110111
