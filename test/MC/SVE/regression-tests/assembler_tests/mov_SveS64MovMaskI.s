// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
mov     z0.d, #0xe0000000000003ff  // 00000101-11000010-00011001-10000000
// CHECK: mov     z0.d, #0xe0000000000003ff // encoding: [0x80,0x19,0xc2,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11000010-00011001-10000000
MOV     Z0.D, #0xE0000000000003FF  // 00000101-11000010-00011001-10000000
// CHECK: mov     z0.d, #0xe0000000000003ff // encoding: [0x80,0x19,0xc2,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11000010-00011001-10000000
mov     z1.d, #0xffff00000003ffff  // 00000101-11000010-10000100-00100001
// CHECK: mov     z1.d, #0xffff00000003ffff // encoding: [0x21,0x84,0xc2,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11000010-10000100-00100001
MOV     Z1.D, #0xFFFF00000003FFFF  // 00000101-11000010-10000100-00100001
// CHECK: mov     z1.d, #0xffff00000003ffff // encoding: [0x21,0x84,0xc2,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11000010-10000100-00100001
