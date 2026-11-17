---
description: Write tests for a file from its API contract, not its implementation
---

Write tests for $ARGUMENTS.

Derive the contract, not the behavior:
1. Read the target's exported signatures, types, and doc comments, plus any spec,
   README, or caller code that states what the API is *supposed* to do. Use the
   implementation only to discover edge cases worth probing, never as the source
   of truth for expected results.
2. Where the contract is ambiguous or silent, pick the behavior it *should* have,
   write the test for that, and mark the line with a comment `ASSUMPTION: ...`.

Writing the tests:
3. Match the project's existing test framework, location, and naming conventions
   (check AGENTS.md for the test command).
4. Cover the contract: normal paths, boundary cases, and error paths.

Constraints, non-negotiable:
5. Do not modify the target file or any other implementation file. Do not add
   stubs, TODOs, or scaffolding to make tests compile.
6. Do not weaken, skip, or delete tests to make them pass.
7. Run the test suite once. Compile errors and failures are expected and are the
   point: report each as "possible implementation bug" or "test bug", then stop.
