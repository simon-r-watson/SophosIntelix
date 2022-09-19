function ConvertTo-Base64String {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
            ValueFromPipeline = $true,
            Position = 0)]
        [string]$String,
        
        [ValidateSet('UTF8', 'Unicode', 'UTF32', 'UTF7', 'ASCII', 'BigEndianUnicode')]
        [string]$Encoding = 'UTF8'
    )
    
    begin {
        
        
    }
    
    process {
        foreach ($str in $String) {
            switch ($Encoding) {
                'UTF8' { $bytes = [System.Text.Encoding]::UTF8.GetBytes($str) }
                'Unicode' { $bytes = [System.Text.Encoding]::Unicode.GetBytes($str) }
                'UTF32' { $bytes = [System.Text.Encoding]::UTF32.GetBytes($str) }
                'UTF7' { $bytes = [System.Text.Encoding]::UTF7.GetBytes($str) }
                'ASCII' { $bytes = [System.Text.Encoding]::ASCII.GetBytes($str) }
                'BigEndianUnicode' { $bytes = [System.Text.Encoding]::BigEndianUnicode.GetBytes($str) }
            }
            [System.Convert]::ToBase64String($bytes)
        }
    }
    
    end {
        
    }
}