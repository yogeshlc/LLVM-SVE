; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

define <n x 16 x i8>* @gep_base_idx32(<n x 16 x i8> *%base, i32 %index) {
; CHECK-LABEL: gep_base_idx32:
; CHECK: sxtw x[[IDX:[0-9]+]], w1
; CHECK: rdvl x[[NUM_BYTES:[0-9]+]], #1
; CHECK: madd x0, x[[NUM_BYTES]], x[[IDX]], x0
; CHECK: ret
  %res = getelementptr <n x 16 x i8>, <n x 16 x i8>* %base, i32 %index
  ret <n x 16 x i8>* %res
}

; TODO: suboptimal code generation
define <n x 8 x i16>* @gep_base_idx64(<n x 8 x i16> *%base, i64 %index) {
; CHECK-LABEL: gep_base_idx64:
; CHECK: cnth x[[NUM_HALFWORDS:[0-9]+]]
; CHECK: mul x[[OFFSET_HAFLWORDS:[0-9]+]], x[[NUM_HALFWORDS]], x1
; CHECK: add x0, x0, x[[OFFSET_HAFLWORDS]], lsl #1
; CHECK: ret
  %res = getelementptr <n x 8 x i16>, <n x 8 x i16>* %base, i64 %index
  ret <n x 8 x i16>* %res
}

define <n x 4 x i32>* @gep_base_imm32(<n x 4 x i32> *%base) {
; CHECK-LABEL: gep_base_imm32:
; CHECK: rdvl x[[NUM_BYTES:[0-9]+]], #1
; CHECK: sub x0, x0, x[[NUM_BYTES]], lsl #12
; CHECK: ret
  %res = getelementptr <n x 4 x i32>, <n x 4 x i32>* %base, i32 -4096 ; -0x1000
  ret <n x 4 x i32>* %res
}

define <n x 4 x i32>* @gep_base_imm32_zero(<n x 4 x i32> *%base) {
; CHECK-LABEL: gep_base_imm32_zero:
; CHECK: ret
  %res = getelementptr <n x 4 x i32>, <n x 4 x i32>* %base, i32 0
  ret <n x 4 x i32>* %res
}

define <n x 4 x i32>* @gep_base_imm32_max_int(<n x 4 x i32> *%base) {
; CHECK-LABEL: gep_base_imm32_max_int:
; CHECK: cntw x[[NUM_WORDS:[0-9]+]]
; CHECK: orr x[[BYTE_INDEX:[0-9]+]], xzr, #0x1fffffffc
; CHECK: madd x0, x[[NUM_WORDS]], x[[BYTE_INDEX]], x0
; CHECK: ret
  %res = getelementptr <n x 4 x i32>, <n x 4 x i32>* %base, i32 2147483647 ; 0x7fffffff
  ret <n x 4 x i32>* %res
}

define <n x 2 x i64>* @gep_base_imm64(<n x 2 x i64> *%base) {
; CHECK-LABEL: gep_base_imm64:
; CHECK: rdvl x[[NUM_BYTES:[0-9]+]], #1
; CHECK: sub x0, x0, x[[NUM_BYTES]], lsl #12
; CHECK: ret
  %res = getelementptr <n x 2 x i64>, <n x 2 x i64>* %base, i64 -4096 ; -0x1000
  ret <n x 2 x i64>* %res
}

define <n x 2 x i64>* @gep_base_imm64_zero(<n x 2 x i64> *%base) {
; CHECK-LABEL: gep_base_imm64_zero:
; CHECK: ret
  %res = getelementptr <n x 2 x i64>, <n x 2 x i64>* %base, i64 0
  ret <n x 2 x i64>* %res
}

define <n x 2 x i64>* @gep_base_imm64_max_int(<n x 2 x i64> *%base) {
; CHECK-LABEL: gep_base_imm64_max_int:
; CHECK: cntd x[[NUM_DOUBLEWORDS:[0-9]+]]
; CHECK: orr x[[BYTE_INDEX:[0-9]+]], xzr, #0x3fffffff8
; CHECK: madd x0, x[[NUM_DOUBLEWORDS]], x[[BYTE_INDEX]], x0
; CHECK: ret
  %res = getelementptr <n x 2 x i64>, <n x 2 x i64>* %base, i64 2147483647 ; 0x7fffffff
  ret <n x 2 x i64>* %res
}

define <n x 2 x i8*> @gep_gather_scalar_index(<n x 2 x i8*> %ptrs, i64 %idx) {
; CHECK-LABEL: gep_gather_scalar_index:
; CHECK: mov z[[OFFSET:[0-9]+]].d, x0
; CHECK-NEXT: add z0.d, z0.d, z[[OFFSET]].d
; CHECK-NEXT: ret
  %res = getelementptr i8, <n x 2 x i8*> %ptrs, i64 %idx
  ret <n x 2 x i8*> %res
}
