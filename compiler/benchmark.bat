del %1
for /L %%i in (1, 1, 9) do echo %%i & ..\compiler\srefc @benchmark_data.lst 2>> %1
del *.cpp
echo.>> %1
echo.>> %1
for %%f in (srefc.exe) do echo File size %%~zf bytes >> %1