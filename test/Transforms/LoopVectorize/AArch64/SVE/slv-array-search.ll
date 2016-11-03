; RUN: opt -mtriple=aarch64-none-linux-gnu -mattr=+sve -O3 -search-loop-vectorize -enable-laa-uncounted-loops -sl-enable-lv-uncounted-loops %s -S -o - | FileCheck %s

; ModuleID = 'SearchArrayIdx.c'
target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-none-linux-gnu"

;; Derived from the SearchVals function in the following c code.
;;#include <stdio.h>
;;#include <stdlib.h>
;;#include <unistd.h>
;;#include <stdint.h>
;;
;;#define NUM_VALS (14)
;;
;;int Vals[NUM_VALS] = { 1, 4, 13, 40, 121, 364, 1093, 3280,
;;                       9841, 29524, 88573, 265720, 797161, 2391484 };
;;
;;__attribute__ ((noinline))
;;int SearchVals(int *Array, int UBound, int BreakVal) {
;;  int Idx = 0;
;;
;;  for (Idx = 0; Idx <= UBound; ++Idx)
;;    if(Array[Idx] >= BreakVal)
;;      break;
;;
;;  return Idx;
;;}
;;
;;int main(int argc, char *argv[]) {
;;  int BreakVal = 80000;
;;  int Idx = SearchVals(Vals, NUM_VALS, BreakVal);
;;  printf("BreakVal = %d, Idx = %d\n", BreakVal, Idx);
;;  return EXIT_SUCCESS;
;;}

; Function Attrs: noinline norecurse nounwind readonly
define i32 @SearchVals(i32* nocapture readonly %Array, i32 %UBound, i32 %BreakVal) #0 {
entry:
  %cmp.6 = icmp slt i32 %UBound, 0
  br i1 %cmp.6, label %for.end, label %for.body.preheader

for.body.preheader:                               ; preds = %entry
  %0 = sext i32 %UBound to i64
  br label %for.body

; CHECK-LABEL: vector.body.unpred:
for.body:                                         ; preds = %for.body.preheader, %for.inc
  %indvars.iv = phi i64 [ 0, %for.body.preheader ], [ %indvars.iv.next, %for.inc ]
  %Idx.07 = phi i32 [ 0, %for.body.preheader ], [ %inc, %for.inc ]
  %arrayidx = getelementptr inbounds i32, i32* %Array, i64 %indvars.iv
  %1 = load i32, i32* %arrayidx, align 4, !tbaa !1
  %cmp1 = icmp sgt i32 %1, %BreakVal
  %2 = trunc i64 %indvars.iv to i32
  br i1 %cmp1, label %for.end.loopexit, label %for.inc

for.inc:                                          ; preds = %for.body
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %inc = add nuw nsw i32 %Idx.07, 1
  %cmp = icmp slt i64 %indvars.iv, %0
  br i1 %cmp, label %for.body, label %for.end.loopexit

for.end.loopexit:                                 ; preds = %for.body, %for.inc
  %Idx.0.lcssa.ph = phi i32 [ %inc, %for.inc ], [ %2, %for.body ]
  br label %for.end

for.end:                                          ; preds = %for.end.loopexit, %entry
  %Idx.0.lcssa = phi i32 [ 0, %entry ], [ %Idx.0.lcssa.ph, %for.end.loopexit ]
  ret i32 %Idx.0.lcssa
}


attributes #0 = { norecurse nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+sve" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0"}
!1 = !{!2, !2, i64 0}
!2 = !{!"int", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
