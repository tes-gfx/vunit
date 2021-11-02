-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this file,
-- You can obtain one at http://mozilla.org/MPL/2.0/.
--
-- Copyright (c) 2014-2021, Lars Asplund lars.anders.asplund@gmail.com

use std.textio.all;

use work.ansi_pkg.all;
use work.log_levels_pkg.all;
use work.string_ops.upper;

library osvvm;
use osvvm.AlertLogPkg.all;

package common_log_pkg is
  constant no_time : time := -1 ns;
  constant no_val : integer := integer'low;
  constant default_mode : natural := 0;

  procedure write_to_log(
    file log_destination : text;
    msg : string := "";
    log_time : time := no_time;
    log_level : string := "";
    log_source_name : string := "";
    mode : natural := default_mode;
    str_1, str_2, str_3, str_4, str_5, str_6, str_7, str_8, str_9, str_10 : string := "";
    val_1, val_2, val_3, val_4, val_5, val_6, val_7, val_8, val_9, val_10 : integer := no_val);
end package;

package body common_log_pkg is

  procedure write_to_log(
    file log_destination : text;
    msg : string := "";
    log_time : time := no_time;
    log_level : string := "";
    log_source_name : string := "";
    mode : natural := default_mode;
    str_1, str_2, str_3, str_4, str_5, str_6, str_7, str_8, str_9, str_10 : string := "";
    val_1, val_2, val_3, val_4, val_5, val_6, val_7, val_8, val_9, val_10 : integer := no_val
  ) is
  begin
    if (log_level = "warning") or (log_level = "error") or (log_level = "failure") then
      Alert(GetAlertLogID(log_source_name), msg, AlertType'value(upper(log_level)));
    elsif (log_level = "debug") then
      osvvm.AlertLogPkg.Log(GetAlertLogID(log_source_name), msg, DEBUG);
    elsif (log_level = "pass") then
      osvvm.AlertLogPkg.Log(GetAlertLogID(log_source_name), msg, PASSED);
    else
      osvvm.AlertLogPkg.Log(GetAlertLogID(log_source_name), msg);
    end if;

  end;

end package body;
