// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
lsl     z21.h, p5/m, z21.h, #10  // 00000100-00000011-10010111-01010101
// CHECK: lsl     z21.h, p5/m, z21.h, #10 // encoding: [0x55,0x97,0x03,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00000011-10010111-01010101
LSL     Z21.H, P5/M, Z21.H, #10  // 00000100-00000011-10010111-01010101
// CHECK: lsl     z21.h, p5/m, z21.h, #10 // encoding: [0x55,0x97,0x03,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00000011-10010111-01010101
lsl     z23.h, p3/m, z23.h, #13  // 00000100-00000011-10001111-10110111
// CHECK: lsl     z23.h, p3/m, z23.h, #13 // encoding: [0xb7,0x8f,0x03,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00000011-10001111-10110111
LSL     Z23.H, P3/M, Z23.H, #13  // 00000100-00000011-10001111-10110111
// CHECK: lsl     z23.h, p3/m, z23.h, #13 // encoding: [0xb7,0x8f,0x03,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00000011-10001111-10110111
lsl     z31.h, p7/m, z31.h, #15  // 00000100-00000011-10011111-11111111
// CHECK: lsl     z31.h, p7/m, z31.h, #15 // encoding: [0xff,0x9f,0x03,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00000011-10011111-11111111
LSL     Z31.H, P7/M, Z31.H, #15  // 00000100-00000011-10011111-11111111
// CHECK: lsl     z31.h, p7/m, z31.h, #15 // encoding: [0xff,0x9f,0x03,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00000011-10011111-11111111
lsl     z0.h, p0/m, z0.h, #0  // 00000100-00000011-10000010-00000000
// CHECK: lsl     z0.h, p0/m, z0.h, #0 // encoding: [0x00,0x82,0x03,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00000011-10000010-00000000
LSL     Z0.H, P0/M, Z0.H, #0  // 00000100-00000011-10000010-00000000
// CHECK: lsl     z0.h, p0/m, z0.h, #0 // encoding: [0x00,0x82,0x03,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00000011-10000010-00000000
