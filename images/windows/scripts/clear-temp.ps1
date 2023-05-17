# Delete temporary items created by installers and such
Remove-Item -Force -Recurse $ENV:TEMP\*
