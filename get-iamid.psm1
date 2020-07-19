function Get-IAMID {
    [cmdletBinding()]

    param 
    (
        [string]$iamdet
    )

    $results = @()
    Try {
        switch -Regex ($iamdet) {
            
            '^AROA' {
                $iamfilter = get-iamroles 
                foreach ($item in $iamfilter) {
                    if ($item.roleid -like "*" + $iamdet+ "*") {
                        $results += $item
                    }
                }
            }
            '^AIDA' {
                $iamfilter = get-iamuserlist
                foreach ($item in $iamfilter) {
                    if ($item.userid -like "*" + $iamdet + "*") {
                        $results += $item
                    }
                }
            }
            '^AGPA' {
                $iamfilter = get-iamgroups
                foreach ($item in $iamfilter) {
                    if ($item.groupid -like "*" + $iamdet + "*") {
                        $results += $item
                    }
                }
            }
        }
    }
    Catch { Write-Output "Unknown Input.  Please enter an ID.  If you entered the correct name the instance may not exist" }
    Write-Output $results
}