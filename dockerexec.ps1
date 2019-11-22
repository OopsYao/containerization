# [CmdletBinding()]
# param (
#     [Parameter(Mandatory)]
#     [string]
#     $Script,

#     [Parameter(ValueFromRemainingArguments)]
#     $Parameters
# )
$Script = $args[0]
$Parameters = $args[1..$args.Length]
$config = Get-Content "./commands.json" | ConvertFrom-Json

$scriptsConfig = $config.scripts.$Script
if (!$scriptsConfig) {
    $Script = $config.alias.$Script
    $scriptsConfig = $config.scripts.$Script
}

$image = $scriptsConfig.image

$workDir = $scriptsConfig.workdir
# if workdir is not configed
if (!$workDir) {
    $workDir = $config.defaultWorkingDir
}

$command = $scriptsConfig.command
# if command is not configed
if (!$command) {
    $command = $Script
}

if (!$Parameters -eq $null) {
    $Parameters = $Parameters.Replace("\", "/") 
}

# Env DISPLAY is intended for VcXsrv
docker run `
    --rm `
    --workdir "$workDir" `
    --env DISPLAY=host.docker.internal:0.0 `
    --volume "${PWD}:$workDir" `
    "$image" `
    "$command" "$Parameters"