-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this file,
-- You can obtain one at http://mozilla.org/MPL/2.0/.
--
-- Copyright (c) 2014-2021, Lars Asplund lars.anders.asplund@gmail.com

library vunit_lib;
context vunit_lib.vunit_context;

library osvvm;
use osvvm.AlertLogPkg.all;

library ieee;
use ieee.std_logic_1164.all;

entity tb_example is
  generic (
    runner_cfg : string);
end entity;

architecture tb of tb_example is

begin
  main : process
    constant logger : logger_t := get_logger("My component");
    constant checker : checker_t := new_checker(logger);
  begin
    test_runner_setup(runner, runner_cfg);
    set_stop_level(failure);

    osvvm.AlertLogPkg.Log(GetAlertLogID("My component"), "Hello from OSVVM");
    Alert(GetAlertLogID("My component"), "An error from OSVVM");

    info(logger, "Hello from VUnit");
    check(checker, false, "An error from VUnit");

    test_runner_cleanup(runner);
  end process;

  test_runner_watchdog(runner, 1000 ns);


end architecture;
