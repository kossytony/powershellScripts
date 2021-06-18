
#set az context by putting the subscription ID
Set-AzContext ""

#get all VMs in the subscription
$myVM = Get-azVM 

#empty array to hold report objects
$missingarray =@()
#variable to create serial No
$SeriesNo = 0

foreach ($VM in $myVM) {

$backup = Get-AzRecoveryServicesBackupStatus -Name $VM.name -ResourceGroupName $VM.ResourceGroupName -Type AzureVM


$seriesNo ++ 
$myobj = [PSCustomObject]@{
    SNo = $SeriesNo
    Name = $VM.name
    ResourceGroup = $VM.ResourceGroupName
    backupStatus = $backup.BackedUp
  
    
}
#$myobj
$missingarray += $myobj
}
$missingarray | export-csv -path "BackupReport.csv" -NoTypeInformation
