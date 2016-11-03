// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
lsl     z31.b, z31.b, #7  // 00000100-00101111-10011111-11111111
// CHECK: lsl     z31.b, z31.b, #7 // encoding: [0xff,0x9f,0x2f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00101111-10011111-11111111
LSL     Z31.B, Z31.B, #7  // 00000100-00101111-10011111-11111111
// CHECK: lsl     z31.b, z31.b, #7 // encoding: [0xff,0x9f,0x2f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00101111-10011111-11111111
lsl     z0.b, z0.b, #0  // 00000100-00101000-10011100-00000000
// CHECK: lsl     z0.b, z0.b, #0 // encoding: [0x00,0x9c,0x28,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00101000-10011100-00000000
LSL     Z0.B, Z0.B, #0  // 00000100-00101000-10011100-00000000
// CHECK: lsl     z0.b, z0.b, #0 // encoding: [0x00,0x9c,0x28,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00101000-10011100-00000000
lsl     z23.b, z13.b, #0  // 00000100-00101000-10011101-10110111
// CHECK: lsl     z23.b, z13.b, #0 // encoding: [0xb7,0x9d,0x28,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00101000-10011101-10110111
LSL     Z23.B, Z13.B, #0  // 00000100-00101000-10011101-10110111
// CHECK: lsl     z23.b, z13.b, #0 // encoding: [0xb7,0x9d,0x28,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00101000-10011101-10110111
lsl     z21.b, z10.b, #5  // 00000100-00101101-10011101-01010101
// CHECK: lsl     z21.b, z10.b, #5 // encoding: [0x55,0x9d,0x2d,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00101101-10011101-01010101
LSL     Z21.B, Z10.B, #5  // 00000100-00101101-10011101-01010101
// CHECK: lsl     z21.b, z10.b, #5 // encoding: [0x55,0x9d,0x2d,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00101101-10011101-01010101
