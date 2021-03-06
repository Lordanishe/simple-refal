@echo off
pushd distrib
rd /q /s bin compiler doc lexgen srlib srmake
xcopy /e /y ..\build\*
md bin
copy ..\src\scripts\srefc.* bin
copy ..\src\scripts\srmake.* bin
ren bin\*.sh *.
xcopy /e /i /y ..\srlib srlib
md doc
xcopy /e /i /y ..\doc\examples doc\examples
copy ..\doc\*.pdf doc
copy ..\doc\*.jpg doc
md doc\historical
copy ..\doc\historical\*.txt doc\historical
copy ..\doc\historical\*.pdf doc\historical
copy ..\doc\historical\*.jpg doc\historical
copy ..\doc\historical\*.doc doc\historical
md doc\historical\�ண㭮�
copy ..\doc\historical\�ண㭮�\*.pdf doc\historical\�ண㭮�
copy ..\LICENSE .
copy ..\README.md .
popd