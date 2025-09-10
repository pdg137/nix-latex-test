This is a demo of how to use [Nix](https://nixos.org/) to start
writing documents in LaTeX.

1. [Install Nix or NixOS](https://nixos.org/download/). (On Debian/Ubuntu systems I prefer to to `apt install nix-bin`.)
2. Clone this repository.
3. Run "nix-build -o shell" to install a basic LaTeX environment (it
   will take a while to download/build everything).
4. Run "./shell" to enter the environment.

Now, you can type `make` to build everything or something like

```
make output/hello.pdf
```

to build a specific document.

(Note: if you have `make` installed on your system, you can run `make
shell` in step 3 and skip step 4 entirely.)
