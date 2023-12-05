# git aliases
function g { git @args }
function gi { git init @args }
function gig { curl -sL https://www.toptal.com/developers/gitignore/api/ @args }
function gcl { git clone @args }
function ga { git add @args }
function gaa { git add --all @args }
function gad { git add . @args }
function gac { git add --all ; git commit -v @args }
function gacm { git add --all ; git commit -m @args }
function gdc { git add . ; git commit -v @args }
function gdcm { git add . ; git commit -m @args }
function gc { git commit -v @args }
function gcm { git commit -m @args }
function gca { git commit --all -v @args }
function gcam { git commit --amend -v @args }
function gcama { git commit --all --amend -v @args }
function gcp { git commit --patch -v @args }
function gph { git push --force-with-lease --follow-tags @args }
function gpha { git push --all --force-with-lease --follow-tags @args }
function gplo { git pull -X ours @args }
function gpl { git pull @args }
function gpla { git pull --all @args }
function gd { git diff @args }
function gds { git diff --staged @args }
function gst { git status @args }
function gl { git log -g @args }
function gsw { git switch @args }
function gch { git checkout @args }
function gchb { git checkout -b @args } # create branch and switch to it
function gr { git restore @args }
function grs { git restore --staged @args }
function gre { git reset @args }
function greh { git reset --hard @args }
function gb { git branch @args }
function gbr { git branch --remotes @args }
function gba { git branch --all @args }
function gbd { git branch --delete @args }
function gm { git merge @args }
function gmc { git merge --no-ff @args }
function gsh { git stash @args }
