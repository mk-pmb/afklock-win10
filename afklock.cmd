@echo off
:: -*- coding: latin-1, tab-width: 2 -*-
::  Repo: https://github.com/mk-pmb/afklock-win10/
::
::  afklock-win10: Help lock your windows workstation when you go afk.
::  Copyright (C) 2019  mk-pmb <mk+copyleft@pimpmybyte.de>
::
::  This program is free software: you can redistribute it and/or modify
::  it under the terms of the GNU General Public License as published by
::  the Free Software Foundation, either version 3 of the License, or
::  (at your option) any later version.
::
::  This program is distributed in the hope that it will be useful,
::  but WITHOUT ANY WARRANTY; without even the implied warranty of
::  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
::  GNU General Public License for more details.
::
::  You should have received a copy of the GNU General Public License
::  along with this program.  If not, see <http://www.gnu.org/licenses/>.

:init
  c:
  cd \
  set tokenfile=b:\token.base64.txt
  set secret=
  set /p secret= < %tokenfile%
  if "%secret%" == "" goto no_secret
  set valid_now=no
:check
  set verify=
  set was_valid=%valid_now%
  set valid_now=no
  set /p verify= < %tokenfile%
  if "%verify%" == "%secret%" set valid_now=yes
  echo %TIME% %was_valid% -^> %valid_now%
  if "%was_valid%,%valid_now%" == "yes,no" call :lock_now
:again
  timeout /t 2 /nobreak >nul:
goto check

:no_secret
  echo E: no secret in %tokenfile%
  :: Easiest way to alert the user that something went wrong:
goto lock_now

:lock_now
  rundll32.exe user32.dll,LockWorkStation
goto end

:end
