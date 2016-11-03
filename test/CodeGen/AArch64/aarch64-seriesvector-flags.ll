; RUN: opt -S %s | FileCheck %s --check-prefix=CHECK

; IR flags check, don't have bitcode support for new instructions yet
; so using opt is the quickest way to test at the moment.

define <n x 4 x i32> @sv_nsw_flag(i32 %x, i32 %y) {
; CHECK: %v = seriesvector nsw i32 %x, %y as <n x 4 x i32>
  %v = seriesvector nsw i32 %x, %y as <n x 4 x i32>
  ret <n x 4 x i32> %v
}

define <n x 4 x i32> @sv_nuw_flag(i32 %x, i32 %y) {
; CHECK: %v = seriesvector nuw i32 %x, %y as <n x 4 x i32>
  %v = seriesvector nuw i32 %x, %y as <n x 4 x i32>
  ret <n x 4 x i32> %v
}

define <n x 4 x i32> @sv_nswnuw_flag(i32 %x, i32 %y) {
; CHECK: %v = seriesvector nuw nsw i32 %x, %y as <n x 4 x i32>
  %v = seriesvector nsw nuw i32 %x, %y as <n x 4 x i32>
  ret <n x 4 x i32> %v
}

define <n x 4 x i32> @sv_nuwnsw_flag(i32 %x, i32 %y) {
; CHECK: %v = seriesvector nuw nsw i32 %x, %y as <n x 4 x i32>
  %v = seriesvector nuw nsw i32 %x, %y as <n x 4 x i32>
  ret <n x 4 x i32> %v
}
