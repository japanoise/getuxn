# getuxn

This is just a suite of scripts to get a nice collection of uxn roms from
upstream.

## Usage

Run `build.sh` to clone & build the world. All roms will be dropped in `roms` in
the current directory, which will be created if it doesn't exist.

You can set the variable `SRCHUT` to `git@git.sr.ht:` if you want to clone using
an SSH key copied to the sourcehut servers, for contributing; by default, this
variable is `https://git.sr.ht/` and so will clone read-only copies using https.

## License

MIT.
