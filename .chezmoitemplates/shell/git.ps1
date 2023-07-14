# git aliases
function g { git }
function gi { git init }
function gig { curl -sL https://www.toptal.com/developers/gitignore/api/ }
function gcl { git clone }
function ga { git add }
function gaa { git add --all }
function gad { git add . }
function gac { git add --all ; git commit -v }
function gacm { git add --all ; git commit -m }
function gdc { git add . ; git commit -v }
function gdcm { git add . ; git commit -m }
function gc { git commit -v }
function gcm { git commit -m }
function gca { git commit --all -v }
function gcam { git commit --amend -v }
function gcama { git commit --all --amend -v }
function gcp { git commit --patch -v }
function gph { git push --force-with-lease --follow-tags }
function gpha { git push --all --force-with-lease --follow-tags }
function gplo { git pull -X ours }
function gpl { git pull }
function gpla { git pull --all }
function gd { git diff }
function gds { git diff --staged }
function gst { git status }
function gl { git log -g }
function gsw { git switch }
function gch { git checkout }
function gchb { git checkout -b } # create branch and switch to it
function gr { git restore }
function grs { git restore --staged }
function gre { git reset }
function greh { git reset --hard }
function gb { git branch }
function gbr { git branch --remotes }
function gba { git branch --all }
function gbd { git branch --delete }
function gm { git merge }
function gmc { git merge --no-ff }
function gsh { git stash }
