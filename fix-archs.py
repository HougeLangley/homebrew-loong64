#!/usr/bin/env python3
import os

BREW = os.path.expanduser("~/homebrew-build/brew")
path = os.path.join(BREW, "Library/Homebrew/hardware.rb")
with open(path, "r") as f:
    content = f.read()
old = "      *ARM_ARCHS,\n    ].freeze, T::Array[Symbol])"
new = "      *ARM_ARCHS,\n      *LOONGARCH_ARCHS,\n    ].freeze, T::Array[Symbol])"
if old in content:
    content = content.replace(old, new)
    with open(path, "w") as f:
        f.write(content)
    print("hardware.rb ALL_ARCHS: FIXED")
else:
    print("hardware.rb ALL_ARCHS: pattern not found, checking current state")
    # check if LOONGARCH_ARCHS already added
    if "LOONGARCH_ARCHS" in content:
        print("  LOONGARCH_ARCHS already present in ALL_ARCHS")
    else:
        print("  ERROR: could not find pattern")
