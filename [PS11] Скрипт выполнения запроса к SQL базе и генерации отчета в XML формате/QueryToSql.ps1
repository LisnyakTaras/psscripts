<# Вариант №1
$SQLServer = "sql-cluster-01.atbmarket.com"
$SQLDBName = "zabbixactivetriggersdb"
$SqlQuery = "SELECT * from triggers03;"
$SqlConnection = New-Object System.Data.SqlClient.SqlConnection
$SqlConnection.ConnectionString = "Server = $SQLServer; Database = $SQLDBName; Integrated Security = True;"
$SqlCmd = New-Object System.Data.SqlClient.SqlCommand
$SqlCmd.CommandText = $SqlQuery
$SqlCmd.Connection = $SqlConnection
$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
$SqlAdapter.SelectCommand = $SqlCmd
$DataSet = New-Object System.Data.DataSet
$SqlAdapter.Fill($DataSet)

$DataSet.Tables[0] | FT id,host,description, lastchangedate | Out-File "C:\Scripts\xxxx.xml"
#>







#Вариант №2, мне больше нравится
#Для него нужно установить модуль: Install-Module -Name SqlServer


$date_from = (get-date).AddDays(-3).ToString("dd.MM.yyyy HH:mm:ss") # за три дня до текущей даты
$date_to = get-date -Format "dd.MM.yyyy HH:mm:ss" # текущая дата

$Qy = "select * from zabbixactivetriggersdb.dbo.triggers03
Where lastchangedate >= '$date_from' AND lastchangedate <= '$date_to'
AND tags = 'group=shop'"

Invoke-Sqlcmd  -Query $Qy -ServerInstance "sql-cluster-01" | Select-Object id, host, lastchangedate, description | Out-File "C:\Scripts\xxxx.xml"
# Sort-Object description ---- я не применял, он здесь безполезен.