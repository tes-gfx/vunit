#!/usr/bin/env python3

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this file,
# You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Copyright (c) 2014-2021, Lars Asplund lars.anders.asplund@gmail.com

from pathlib import Path
from itertools import product
from vunit import VUnit, VUnitCLI

cli = VUnitCLI()
cli.parser.add_argument(
    "--use-vunit-log",
    action="store_true",
    default=False,
    help="Re-direct OSVVM log output to VUnit log handling",
)
cli.parser.add_argument(
    "--use-osvvm-log",
    action="store_true",
    default=False,
    help="Re-direct VUnit log output to OSVVM log handling",
)
args = cli.parse_args()
args.clean = True
prj = VUnit.from_args(args=args, compile_builtins=False)
root = Path(__file__).parent
if args.use_osvvm_log:
    prj.add_builtins(use_external_log=Path(root / "osvvm_integration" / "common_log_pkg_vunit_to_osvvm.vhd"))
else:
    prj.add_builtins()

prj.add_osvvm(args.use_vunit_log)
lib = prj.add_library("lib")
lib.add_source_files(root / "*.vhd")
prj.set_compile_option("rivierapro.vcom_flags", ["-dbg"])
prj.main()
