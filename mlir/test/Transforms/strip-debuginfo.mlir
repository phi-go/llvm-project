// RUN: mlir-opt %s -mlir-print-debuginfo -strip-debuginfo | FileCheck %s
// This test verifies that debug locations are stripped.

#set0 = affine_set<(d0) : (1 == 0)>

// CHECK-LABEL: func @inline_notation
func @inline_notation() -> i32 {
  // CHECK: "foo"() : () -> i32 loc(unknown)
  %1 = "foo"() : () -> i32 loc("foo")

  // CHECK: } loc(unknown)
  affine.for %i0 = 0 to 8 {
  } loc(fused["foo", "mysource.cc":10:8])

  // CHECK: } loc(unknown)
  %2 = constant 4 : index
  affine.if #set0(%2) {
  } loc(fused<"myPass">["foo", "foo2"])

  // CHECK: return %0 : i32 loc(unknown)
  return %1 : i32 loc("bar")
}
