




$subscriptions = Get-AzSubscription



foreach ( $subscription in $subscriptions ) {

#set az context by putting the subscription ID
Set-AzContext ""

#get all VMs in the subscription
$myVM = Get-azVM 

#empty array to hold report objects
$missingarray =@()
#variable to create serial No
$SeriesNo = 0

#looping through list of VMs
foreach ($VM in $myVM) {

$backup = Get-AzRecoveryServicesBackupStatus -Name $VM.name -ResourceGroupName $VM.ResourceGroupName -Type AzureVM

#Building Object of the report
$seriesNo ++ 
$myobj = [PSCustomObject]@{
    SNo = $SeriesNo
    Name = $VM.name
    ResourceGroup = $VM.ResourceGroupName
    backupStatus = $backup.BackedUp
  
    
}

#adding objects to the Array
$missingarray += $myobj
}
]
#Piping array to the export-csv function to create a CSV file.
$missingarray | export-csv -path "BackupReport.csv" -NoTypeInformation
