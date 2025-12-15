# Get writer status and ommit empty lines
$writers = vssadmin list writers | Select-String -Context 0,4 -Pattern "^writer name:"

# create a table with colums for all the writer properties
$table = new-object system.data.datatable
$table.Columns.Add("Name")
$table.Columns.Add("ID")
$table.Columns.Add("InstanceID")
$table.Columns.Add("State")
$table.Columns.Add("Error")

# Loop through all writers
foreach ($Writer in $writers)
{
    # Convert the matchobject to an array for further processing
    $Cleaned = $Writer.ToString().Replace("> Writer name:","").Split("`n").Replace("    ","").Replace("'","")

    # Create a new table row
    $Row = $Table.NewRow()
    # Add all the properties, trim the string and replace propertynames and braces
    $Row.Name = $Cleaned[0].Trim()
    $Row.ID = $Cleaned[1].Replace("Writer Id: {","").Replace("}","").Trim()
    $Row.InstanceID = $Cleaned[2].Replace("Writer Instance Id: {","").Replace("}","").Trim()
    $row.State = $Cleaned[3].Replace("State: [1] ","").Trim()
    $row.Error = $Cleaned[4].Replace("Last error: ","").Trim()

    # Add the row to the table
    $table.Rows.Add($row)
}

$table | ogv
