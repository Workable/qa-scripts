ls -1 | xargs -I{} ln -s $(pwd)/{} ~/.scripts/{}1
ls -1 | xargs -I{} mv ~/.scripts/{}1 ~/.scripts/{}