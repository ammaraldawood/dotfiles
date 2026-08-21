# Dotfiles

Zsh, Tmux, Ghostty, and Neovim. macOS and Linux.

This repo does not install software. Clone it, symlink it, and bring your own tools.

## Highlights

**Shell**

| Command | What it does |
| --- | --- |
| `ghosttyconfig` | Open the Ghostty config in Neovim |
| `darkacademia` | Play a dark-academia playlist in mpv (audio only) |
| `nf` | Fuzzy-find files and open the selection in Neovim |
| `y` | Open yazi, then `cd` into the last directory you left it in |
| `cld` | Page the newest file in `~/Downloads` with bat |
| `ls` | eza: git status, icons, sizes, directories first |
| `cat` | bat |
| `cd` | zoxide |
| `python` | `python3` |

`less` is set to numbered, no-wrap, with horizontal scroll. `more` is the same thing.

**bioSyntax, ready to use**

Syntax highlighting for common bioinformatics formats in both the pager and Neovim. No enable-file, no extra setup beyond installing [source-highlight](https://www.gnu.org/software/src-highlite/) and the [bioSyntax](https://biosyntax.org) language files.

```bash
samtools view -h aligned_hits.bam | sam-less
```

| Alias | Format |
| --- | --- |
| `sam-less` / `bam-less` | SAM / BAM |
| `vcf-less` | VCF |
| `fa-less` / `fq-less` | FASTA / FASTQ |
| `gtf-less` | GTF |
| `bed-less` | BED |
| `pdb-less` | PDB |
| `clustal-less` | Clustal |
| `fai-less` | FASTA index |
| `flagstat-less` | samtools flagstat |

Neovim loads `bioSyntax-vim` and `bioinformatics.nvim` with the rest of the plugin tree. Snakemake (`Snakefile`, `*.smk`) and Quarto (`*.qmd`) are recognized as filetypes.

**Terminal**

Ghostty uses a blue/orange palette, Monaspace (Argon / Xenon / Radon / Krypton), texture-healing ligatures, and a custom shader. The same palette is in lualine. Config lives at `~/.config/ghostty` on both platforms; `macos-titlebar-style` only affects macOS.

Tmux: `|` and `-` splits, hjkl resize, vim-aware pane movement, resurrect / continuum, graphics passthrough so image.nvim works inside Tmux.

**Neovim**

lazy.nvim bootstraps on first launch. Oil, Telescope, Flash, lazygit, Mason, LSP, DAP, Molten + Quarto for notebooks, VimTeX with zathura. Deletes (`d` / `c` / `x`) stay off the clipboard. nvim-treesitter tracks `main`, which needs Neovim 0.12+.

## Layout

```
.zshrc
.p10k.zsh
.tmux.conf
.config/nvim/          # Neovim (lazy.nvim)
.config/ghostty/       # palette, Monaspace, shader
install.sh             # symlinks only
LICENSE
```

## Install

```bash
git clone https://github.com/ammaraldawood/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

`install.sh` is Zsh. It links these files into `$HOME` and `${XDG_CONFIG_HOME:-$HOME/.config}`. On macOS it also links Ghostty into `~/Library/Application Support/com.mitchellh.ghostty`. Existing real files are moved to `*.bak`. Windows is not supported.

## What you install

Whatever the configs call, for example:

- Ghostty, Neovim 0.12+, Tmux, Zsh
- Oh-My-Zsh!, Powerlevel10k, zsh-autosuggestions, zsh-syntax-highlighting (Homebrew or your distro / oh-my-zsh custom paths — `.zshrc` looks in both)
- Monaspace Variable and a Nerd Font (Meslo LG is what the prompt expects)
- eza, bat, fzf, zoxide, yazi, ripgrep, fd, lazygit, btop, mpv, yt-dlp
- `tree-sitter-cli` (nvim-treesitter `main` uses it to build parsers)
- ImageMagick (Molten / image.nvim)
- source-highlight + bioSyntax language files (for the `*-less` aliases)
- Linux clipboard for Neovim: `wl-clipboard` (Wayland) or `xclip` / `xsel` (X11)

Tmux plugins (TPM, vim-tmux-navigator, resurrect, continuum) are declared in `.tmux.conf`. Clone TPM to `~/.tmux/plugins/tpm`, then prefix + `I`.

Mason auto-installs `stylua`, `flake8`, and `shellcheck`. Language servers listed in `lspconfig.lua` (`lua_ls`, plus a few web ones) are enabled there — install the binaries yourself (Mason UI is fine).

For Molten / image.nvim: `pip install pynvim jupyter_client ipykernel`.

Skip `p10k configure` unless you want a different prompt — `.p10k.zsh` is already here.
