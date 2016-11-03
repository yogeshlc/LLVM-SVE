; RUN: opt -mtriple=aarch64-none-linux-gnu -mattr=+sve -O3 -search-loop-vectorize -enable-laa-uncounted-loops -sl-enable-lv-uncounted-loops %s -S -o - | FileCheck %s

; ModuleID = 'SearchArrayIdxExactElement.c'
target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64--linux-gnu"

;; Derived from the SearchForElement function in the following source
;;#include <stdio.h>
;;#include <stdlib.h>
;;#include <unistd.h>
;;#include <stdint.h>
;;
;;#define NUM_VALS (16)
;;
;;int ValsWithElement[NUM_VALS] =    { 713024,  12114,   1520617, 2015440,
;;                                     2491301, 349720,  3220351, 3021090,
;;                                     2551752, 340478,  2298854, 2980012,
;;                                     223373,  221896,  557193,  1626056 };
;;
;;__attribute__ ((noinline))
;;int SearchForElement(int *Array, int Size, int Element) {
;;  int Idx;
;;  for (Idx = 0; Idx < Size; ++Idx)
;;    if (Array[Idx] == Element)
;;      break;
;;
;;  return Idx;
;;}
;;
;;int main(int argc, char *argv[]) {
;;  int ElementToFind = 340478;
;;
;;  int Idx = SearchForElement(ValsWithElement, NUM_VALS, ElementToFind);
;;  printf("Idx of Element: %d\n", Idx);
;;
;;  return EXIT_SUCCESS;
;;}

; Function Attrs: noinline norecurse nounwind readonly
define i32 @SearchForElement(i32* nocapture readonly %Array, i32 %Size, i32 %Element) #0 {
entry:
  %cmp.6 = icmp sgt i32 %Size, 0
  br i1 %cmp.6, label %for.body.preheader, label %for.end

for.body.preheader:                               ; preds = %entry
  %0 = sext i32 %Size to i64
  br label %for.body

; CHECK-LABEL: vector.body.unpred:

for.body:                                         ; preds = %for.body.preheader, %for.inc
  %indvars.iv = phi i64 [ 0, %for.body.preheader ], [ %indvars.iv.next, %for.inc ]
  %Idx.07 = phi i32 [ 0, %for.body.preheader ], [ %inc, %for.inc ]
  %arrayidx = getelementptr inbounds i32, i32* %Array, i64 %indvars.iv
  %1 = load i32, i32* %arrayidx, align 4, !tbaa !1
  %cmp1 = icmp eq i32 %1, %Element
  %2 = trunc i64 %indvars.iv to i32
  br i1 %cmp1, label %for.end.loopexit, label %for.inc

for.inc:                                          ; preds = %for.body
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %inc = add nuw nsw i32 %Idx.07, 1
  %cmp = icmp slt i64 %indvars.iv.next, %0
  br i1 %cmp, label %for.body, label %for.end.loopexit

for.end.loopexit:                                 ; preds = %for.body, %for.inc
  %Idx.0.lcssa.ph = phi i32 [ %inc, %for.inc ], [ %2, %for.body ]
  br label %for.end

for.end:                                          ; preds = %for.end.loopexit, %entry
  %Idx.0.lcssa = phi i32 [ 0, %entry ], [ %Idx.0.lcssa.ph, %for.end.loopexit ]
  ret i32 %Idx.0.lcssa
}

attributes #0 = { noinline norecurse nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+sve" "unsafe-fp-math"="true" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0"}
!1 = !{!2, !2, i64 0}
!2 = !{!"int", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
