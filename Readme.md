# GET-VSSWriterStatus

A PowerShell script to display the status of all VSS writers of a windwos system and being able to filter on differnet properties.

Uses "vssadmin list writers" to get the data from the OS. PowerShell is used to transform the output and display it with Out-Gridview.
