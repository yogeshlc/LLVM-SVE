; RUN: opt -mtriple=aarch64-none-linux-gnu -mattr=+sve -O3 -search-loop-vectorize -enable-laa-uncounted-loops -sl-enable-lv-uncounted-loops %s -S -o - | FileCheck %s

; ModuleID = 'ContainsElement.c'
target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64--linux-gnu"

;; Derived from the ContainsElement function in the following source
;;#include <stdio.h>
;;#include <stdlib.h>
;;#include <unistd.h>
;;#include <stdint.h>
;;#include <stdbool.h>
;;
;;#define NUM_VALS (16)
;;
;;int ValsWithElement[NUM_VALS] =    { 713024,  12114,   1520617, 2015440,
;;                                     2491301, 349720,  3220351, 3021090,
;;                                     2551752, 340478,  2298854, 2980012,
;;                                     223373,  221896,  557193,  1626056 };
;;int ValsWithoutElement[NUM_VALS] = { 2896351, 3236854, 1069657, 1482542,
;;                                     764087,  149100,  1513846, 2140944,
;;                                     604533,  645390,  1371560, 2758877,
;;                                     251580,  2466821, 3141530, 2000995 };
;;
;;__attribute__ ((noinline))
;;bool ContainsElement(int *Array, int Size, int Element) {
;;  unsigned Idx;
;;  for (Idx = 0; Idx < Size; ++Idx)
;;    if (Array[Idx] == Element)
;;      return true;
;;
;;  return false;
;;}
;;
;;int main(int argc, char *argv[]) {
;;  int ElementToFind = 340478;
;;
;;  bool First = ContainsElement(ValsWithElement, NUM_VALS, ElementToFind);
;;  printf("First array contains elem? %s\n", First ? "Yes" : "No");
;;
;;  bool Second = ContainsElement(ValsWithoutElement, NUM_VALS, ElementToFind);
;;  printf("Second array contains elem? %s\n", Second ? "Yes" : "No");
;;
;;  return EXIT_SUCCESS;
;;}

; Function Attrs: noinline norecurse nounwind readonly
define i1 @ContainsElement(i32* nocapture readonly %Array, i32 %Size, i32 %Element) #0 {
entry:
  %cmp.5 = icmp eq i32 %Size, 0
  br i1 %cmp.5, label %cleanup, label %for.body.preheader

for.body.preheader:                               ; preds = %entry
  br label %for.body

for.cond:                                         ; preds = %for.body
  %cmp = icmp ult i32 %inc, %Size
  br i1 %cmp, label %for.body, label %cleanup.loopexit

; CHECK-LABEL: vector.body.unpred:

for.body:                                         ; preds = %for.body.preheader, %for.cond
  %Idx.06 = phi i32 [ %inc, %for.cond ], [ 0, %for.body.preheader ]
  %idxprom = zext i32 %Idx.06 to i64
  %arrayidx = getelementptr inbounds i32, i32* %Array, i64 %idxprom
  %0 = load i32, i32* %arrayidx, align 4, !tbaa !1
  %cmp1 = icmp eq i32 %0, %Element
  %inc = add i32 %Idx.06, 1
  br i1 %cmp1, label %cleanup.loopexit, label %for.cond

cleanup.loopexit:                                 ; preds = %for.cond, %for.body
  %retval.0.ph = phi i1 [ true, %for.body ], [ false, %for.cond ]
  br label %cleanup

cleanup:                                          ; preds = %cleanup.loopexit, %entry
  %retval.0 = phi i1 [ false, %entry ], [ %retval.0.ph, %cleanup.loopexit ]
  ret i1 %retval.0
}


attributes #0 = { noinline norecurse nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+sve" "unsafe-fp-math"="true" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0"}
!1 = !{!2, !2, i64 0}
!2 = !{!"int", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
