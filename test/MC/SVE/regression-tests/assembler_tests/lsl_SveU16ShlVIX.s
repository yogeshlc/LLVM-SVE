// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
lsl     z23.h, z13.h, #8  // 00000100-00111000-10011101-10110111
// CHECK: lsl     z23.h, z13.h, #8 // encoding: [0xb7,0x9d,0x38,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00111000-10011101-10110111
LSL     Z23.H, Z13.H, #8  // 00000100-00111000-10011101-10110111
// CHECK: lsl     z23.h, z13.h, #8 // encoding: [0xb7,0x9d,0x38,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00111000-10011101-10110111
lsl     z31.h, z31.h, #15  // 00000100-00111111-10011111-11111111
// CHECK: lsl     z31.h, z31.h, #15 // encoding: [0xff,0x9f,0x3f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00111111-10011111-11111111
LSL     Z31.H, Z31.H, #15  // 00000100-00111111-10011111-11111111
// CHECK: lsl     z31.h, z31.h, #15 // encoding: [0xff,0x9f,0x3f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00111111-10011111-11111111
lsl     z0.h, z0.h, #0  // 00000100-00110000-10011100-00000000
// CHECK: lsl     z0.h, z0.h, #0 // encoding: [0x00,0x9c,0x30,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00110000-10011100-00000000
LSL     Z0.H, Z0.H, #0  // 00000100-00110000-10011100-00000000
// CHECK: lsl     z0.h, z0.h, #0 // encoding: [0x00,0x9c,0x30,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00110000-10011100-00000000
lsl     z21.h, z10.h, #5  // 00000100-00110101-10011101-01010101
// CHECK: lsl     z21.h, z10.h, #5 // encoding: [0x55,0x9d,0x35,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00110101-10011101-01010101
LSL     Z21.H, Z10.H, #5  // 00000100-00110101-10011101-01010101
// CHECK: lsl     z21.h, z10.h, #5 // encoding: [0x55,0x9d,0x35,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00110101-10011101-01010101
