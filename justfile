build:
  docker build -t jotamudo/nvim:v1 -f Dockerfile .

run:
  docker run -it -v "$HOME"/.gitconfig:/root/.gitconfig -v "$HOME"/.ssh:/root/.ssh -v "$PWD":/mnt/volume -w=/mnt/volume jotamudo/nvim:v1

