

PowerShell splatting is a method of passing parameters to commands and scripts, which enhances readability and maintainability of your code. 
Instead of writing a long command with many parameters, splatting allows you to define all the parameters and their values in a hashtable or array, 
and then pass this collection to the command.

## How Splatting Works 

### 1. Create a Hashtable or Array:
- For a hashtable, you use key-value pairs, where the keys correspond to the parameter names of the command, and the values are the arguments you want to pass.
- For indexed commands and scripts, you can use an array.

### 2. Pass the Hashtable or Array to the Command:
- To use the hashtable or array in a command, prefix it with @ and use it as the argument.

## Advantages of Splatting
- Improved Readability: It makes your command more readable, especially when a command requires many parameters.
- Easy to Modify: You can easily add, remove, or modify parameters in the hashtable or array.
- Reduces Errors: Helps in avoiding line continuation errors in scripts.
- Reusable: The same splatting hashtable or array can be reused for similar commands.

## Example Without Splatting
```powershell
Copy-DbaDbTableData -SqlInstance TEST01 -Database DBA -Table TestTable -Destination $localhost -DestinationDatabase DBALocal -DestinationTable TestTable -AutoCreateTable
```

## Example With Splatting
```powershell
$params = @{
  SqlInstance='TEST01'
  Database='DBA'
  Table='TestTable'
  Destination=$localhost
  DestinationDatabase='DBALocal'
  DestinationTable='TestTable'
  AutoCreateTable= $true
}

Copy-DbaDbTableData @params
```

Splatting is particularly useful in scripts and functions where commands with a large number of parameters are common. 
It helps in making your scripts more organized and easier to understand.
