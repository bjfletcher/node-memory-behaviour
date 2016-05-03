# Motivation

The motivation is to better understand memory behaviour with Node applications - in particular when the memory limit of the machine is reached such as on Heroku.

# Getting Started

## Docker

This uses Docker to setup a machine with memory constraints to test.

If not already setup:

```sh
brew cask install virtualbox
brew install docker docker-machine
docker-machine create --driver virtualbox dev
```

Verify that it is running:

```sh
docker-machine ls
docker-machine start dev
```

Setup the environment variables:

```sh
docker-machine env dev
```

which will detect the shell used and tell you what command to run.

Finally, build the image:

```sh
make build
```

## Running tests

```sh
make run
```

That will run a number of different machine configuration and Node memory settings.  Some running fine, some running faster than others, and some getting killed for exceeding memory constraints.

## Notes

I'd pay particular attention to [this comment](https://github.com/nodejs/node/issues/3370#issuecomment-158521878) on GitHub:

> For what it's worth, here's the solution we're trying now (I sure wish I had found this conversation before!!):

```sh
if [ ! "$WEB_MEMORY" = "" ]; then
  if [ $WEB_MEMORY -le 512 ]; then
    NODE_FLAGS="--max_semi_space_size=2 --max_old_space_size=256 --max_executable_size=192"
  elif [ $WEB_MEMORY -le 768 ]; then
    NODE_FLAGS="--max_semi_space_size=8 --max_old_space_size=512 --max_executable_size=384"
  elif [ $WEB_MEMORY -le 1024 ]; then
    NODE_FLAGS="--max_semi_space_size=16 --max_old_space_size=1024 --max_executable_size=512"
  fi
fi

node $NODE_FLAGS "$@"
```

> I'm getting the values for those flags from the [V8 defaults](https://github.com/nodejs/node/blob/master/deps/v8/src/api.cc#L501), and it seems to be working great so far (Heroku / 512mb).
