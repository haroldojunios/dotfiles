RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color

pacman -Syu --noconfirm

packageList=(
  clang
  diffutils
  dos2unix
  fish
  git
  make
  mingw-w64-x86_64-bat
  mingw-w64-x86_64-imagemagick
  mingw-w64-x86_64-jq
  mingw-w64-x86_64-shfmt
  mingw-w64-x86_64-starship
  mingw-w64-x86_64-texlive-bibtex-extra
  mingw-w64-x86_64-texlive-extra-utils
  mingw-w64-x86_64-texlive-font-utils
  mingw-w64-x86_64-texlive-formats-extra
  mingw-w64-x86_64-texlive-lang-portuguese
  mingw-w64-x86_64-texlive-latex-extra
  mingw-w64-x86_64-texlive-pstricks
  mingw-w64-x86_64-texlive-publishers
  mingw-w64-x86_64-texlive-science
  mingw-w64-x86_64-python
  p7zip
  parallel
  rsync
  unzip
)

for package in "${packageList[@]}"; do
  if ! pacman -Q ${package} &>/dev/null && ! [ "$(pacman -Sg ${package})" = "$(pacman -Qg ${package} 2>&1)" ]; then
    echo -e "${GREEN}Installing package ${BLUE}${package}${GREEN}...${NC}"
    pacman -S --noconfirm --needed ${package} ||
      echo -e "${RED}Package(s) \"${BLUE}${package}${RED}\" not found!${NC}"
  fi
done

pacman -Qtdq | pacman -Rns --noconfirm 2>/dev/null || :
