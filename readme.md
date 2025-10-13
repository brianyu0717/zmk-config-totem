# Graphical editor

Requires github login in browser

https://nickcoutsos.github.io/keymap-editor/

# Edit files directly

## Ensure installed

- `jq`
- `gh` - github cli, logged in

## Steps

- adjust the totem.keymap file (find all the keycodes on [the zmk docs pages](https://zmk.dev/docs/codes/))
- run script `push_and_download.sh`, flags `-a` amend will prompt for commit message; `-n` amend no 
edit - amend and keep existing message, no args creates a new commit.
- connect the left half of the TOTEM to your PC, press reset twice
- the keyboard should now appear as a mass storage device
- drag'n'drop the `totem_left-seeeduino_xiao_ble-zmk.uf2` file from the archive onto the storage device
- repeat this process with the right half and the `totem_right-seeeduino_xiao_ble-zmk.uf2` file.

# Left side doesn't appear as mass storage when put in bootloader

Try flip the usb c cable, ie turn it 180 degree