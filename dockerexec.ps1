[CmdletBinding()]
param (
    [Parameter(Mandatory)]
    [string]
    $Script,

    [Parameter(ValueFromRemainingArguments)]
    [string]
    $Parameters
)
$config = Get-Content "./commands.json" | ConvertFrom-Json

$scriptsConfig = $config.scripts.$Script
if (!$scriptsConfig) {
    $Script = $config.alias.$Script
    $scriptsConfig = $config.scripts.$Script
}

$image = $scriptsConfig.image
$workDir = $scriptsConfig.workdir
$command = $scriptsConfig.command

if (!$command) {
    $command = $Script
}

$Parameters = $Parameters.Replace("\", "/")
docker run --rm -w "$workDir" -v ${PWD}:"$workDir" -e DISPLAY=host.docker.internal:0.0 "$image" "$command" "$Parameters"