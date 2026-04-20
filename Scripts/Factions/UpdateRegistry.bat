@echo off
set "MISSION_ROOT=%~dp0..\.."
echo --- FBT Manual Registry Rebuilder ---
echo Mission Root: %MISSION_ROOT%
echo.

:: Call the Python Governor CLI directly
py "%MISSION_ROOT%\Scripts\Faction_Builder_Tool\fbt_manager.py" "%MISSION_ROOT%"

echo.
pause
