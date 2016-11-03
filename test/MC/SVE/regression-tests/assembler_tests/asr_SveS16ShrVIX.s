// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
asr     z21.h, z10.h, #11  // 00000100-00110101-10010001-01010101
// CHECK: asr     z21.h, z10.h, #11 // encoding: [0x55,0x91,0x35,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00110101-10010001-01010101
ASR     Z21.H, Z10.H, #11  // 00000100-00110101-10010001-01010101
// CHECK: asr     z21.h, z10.h, #11 // encoding: [0x55,0x91,0x35,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00110101-10010001-01010101
asr     z23.h, z13.h, #8  // 00000100-00111000-10010001-10110111
// CHECK: asr     z23.h, z13.h, #8 // encoding: [0xb7,0x91,0x38,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00111000-10010001-10110111
ASR     Z23.H, Z13.H, #8  // 00000100-00111000-10010001-10110111
// CHECK: asr     z23.h, z13.h, #8 // encoding: [0xb7,0x91,0x38,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00111000-10010001-10110111
asr     z31.h, z31.h, #1  // 00000100-00111111-10010011-11111111
// CHECK: asr     z31.h, z31.h, #1 // encoding: [0xff,0x93,0x3f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00111111-10010011-11111111
ASR     Z31.H, Z31.H, #1  // 00000100-00111111-10010011-11111111
// CHECK: asr     z31.h, z31.h, #1 // encoding: [0xff,0x93,0x3f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00111111-10010011-11111111
asr     z0.h, z0.h, #16  // 00000100-00110000-10010000-00000000
// CHECK: asr     z0.h, z0.h, #16 // encoding: [0x00,0x90,0x30,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00110000-10010000-00000000
ASR     Z0.H, Z0.H, #16  // 00000100-00110000-10010000-00000000
// CHECK: asr     z0.h, z0.h, #16 // encoding: [0x00,0x90,0x30,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00110000-10010000-00000000
