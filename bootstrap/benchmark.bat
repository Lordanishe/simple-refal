setlocal
  call ..\c-plus-plus.conf.bat
  del int-%1 comp-%1
  set FILES=srefc Algorithm Context Error FindFile Generator Lexer ParseCmdLine Parser^
    SymTable refalrts Library LibraryEx
  for /L %%i in (1, 1, 3) do (
    echo Interpret %%i
    ..\compiler\srefc -c "%CPPLINE% -I../srlib -DINTERPRET" %FILES% 2>> int-%1
  )
  for /L %%i in (1, 1, 3) do (
    echo Compile %%i
    ..\compiler\srefc -c "%CPPLINE% -I../srlib" %FILES% 2>> comp-%1
  )
  del *.exe
  if exist *.obj del *.obj
  if exist *.o del *.o
  if exist *.tds del *.tds
endlocal