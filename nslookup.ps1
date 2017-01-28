while (1)
{
    Get-Date -Format "==== yyyy-MM-ddTHH:mm:ss ================================"
    nslookup dav.progdence.co.jp 2>$null
    Write-Output ""
    Start-Sleep -s 1
}
