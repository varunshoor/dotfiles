source ~/.config/zsh/init.zsh

# Find all .zsh files in ~/.config/zsh, exclude 'init.zsh'.
FILES_STR=$(fd --glob '*.zsh' --exclude 'init.zsh' --exclude 'end.zsh'  ~/.config/zsh)
# 'tr' is a find-and-replace utility.
# Outer () will convert the output of $() to array.
FILES=($(echo $FILES_STR | tr '\n' ' '))
for FILE in $FILES; do
  source $FILE
done

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/varunshoor/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

source ~/.config/zsh/end.zsh
