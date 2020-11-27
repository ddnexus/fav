# fav

`zsh`/`fzf` plugin: easily add and recall named favorites of your important directories and files.

## Usage

### Add favorite

Add any dir or file as a favorite: 

```
~/repos/dd/oss/ruby/pagy $ fav add
[ADDED]  D  pagy  /home/dd/repos/dd/oss/ruby/pagy

~/repos/dd/oss/ruby/pagy $ fav add -f CHANGELOG.md
[ADDED]  F  CHANGELOG.md  /home/dd/repos/dd/oss/ruby/pagy/CHANGELOG.md

```

Add arbitrary named favorites:

```
~/repos/dd/oss/docker/files $ fav add docf
[ADDED]  D  docf /home/dd/repos/dd/oss/docker/files

/opt/vivaldi/resources/vivaldi/hooks $ fav add vivh
[ADDED]  D  vivh  /opt/vivaldi/resources/vivaldi/hooks

~/repos/dd/oss/ruby/pagy $ fav add -f README.md pagy-readme
[ADDED]  F  pagy-readme  /home/dd/repos/dd/oss/ruby/pagy/README.md
```

### Use the favorite shortcuts

Use the saved favorite names in place of the actual dirs or files:

```
~ $ cd ~pagy           # normal cd
~ $ ~pagy              # cd with AUTO_CD zsh option
~ $ ~pa<tab><enter>    # completes ~pagy and cd to it
~ $ pagy               # cd with AUTO_CD + CDABLE_VARS zsh options
~ $ pagy/lib/extras    # cd with AUTO_CD + CDABLE_VARS zsh options in sub-path
~ $ nano ~pagy-readme  # use the file using its fav name
```

### Use the fzf widget

Use the `fzf` widget to search the favs and insert in the `ZLE` buffer:

```
~ $ ls <alt-v>
<pick one or more favorites with fzf>
~ $ ls ~docf ~pagy
...
~ $ cat <alt-v>
<pick one or more favorites with fzf>
~ $ cat ~pagy-readme CHANGELOG.md
...
```

### List favorites

List the favorites (ordered by -name):

```
~ $ fav list -name
F  CHANGELOG.md  /home/dd/repos/dd/oss/ruby/pagy/CHANGELOG.md
D  docf          /home/dd/repos/dd/oss/docker/files
?  old           /path/old
?  older         /path/older
D  pagy          /home/dd/repos/dd/oss/ruby/pagy
F  pagy-readme   /home/dd/repos/dd/oss/ruby/pagy/README.md
D  vivh          /opt/vivaldi/resources/vivaldi/hooks
```

**Notice**: you can also enable the icons from the [Nerd Fonts](https://www.nerdfonts.com) instead of just `F D ?` in the first column

### Remove favorites

Remove named favorite(s):

```
~ $ fav remove doc     # autocompletes (if only one matches) or opens the fzf panel
[REMOVED]  D  docf  /home/dd/repos/dd/oss/docker/files
```

Remove selected favorites with fzf panel:

```
~ $ fav remove
<pick one or more favs with fzf>
[REMOVED]  D  vivh  /opt/vivaldi/resources/vivaldi/hooks
```

### Clean unknown paths

Removes all the favorites pointing to a unknown path:

```
~ $ fav clean
[REMOVED]  ?  old    /path/old
[REMOVED]  ?  older  /path/older
```

## Install

Make sure you have [`fzf`](https://github.com/junegunn/fzf) installed.

### with [zplug](https://github.com/zplug/zplug)

``` zsh
zplug "ddnexus/fav"
```

### with [zgen](https://github.com/tarjoilija/zgen)

``` zsh
zgen load ddnexus/fav
```

### with [antigen](https//github.com/zsh-users/antigen)

``` zsh
antigen bundle ddnexus/fav
```

### Manually

Add `source "/your/path/to/fav.plugin.zsh"` in your `~/.zshrc`.

## Commands

| Command                | Action                                                                                                                                                                   |
| ---------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `add [-f FILE] [NAME]` | Add the current dir or the `FILE` in it as `NAME`. If missing, `NAME` is generated based on `basename $PWD` or `FILE`                                                    |
| `~NAME`                | Generated alias that expands to the full favorite path, internally declared with `hash -d NAME=/favorite/path` (see `man zshbuiltins` /hash)                             |
| `fav remove [QUERY]`   | Remove selected favorites: `fav` matches the optional `QUERY` to `NAME` and removes it if it gets a single match. No `QUERY` or multiple matches open the `fzf` panel    |
| `fav list [ORDER]`     | Print the list of all the favorites. ORDER order can be `-type`, `-name`, `-path` or `-time` or reversed with `-rtype`, `-rname`, `-rpath` or `-rtime` (default `-time`) |
| `fav clean`            | Remove all the favorites pointing to an unknown path                                                                                                                     |
| `fav env`              | Show the value of variables and options                                                                                                                                  |
| `fav help`             | Show an usage screen                                                                                                                                                     |
| `alt-v`                | Default `FAV_WIDGET_KEY` binding to the `fav::widget`. It opens the `fzf` panel listing all favs. It pastes the selected favorites into the `ZLE` buffer                 |

## Options

| Variable               | Description                                                                                                                       | Default             |
| ---------------------- | --------------------------------------------------------------------------------------------------------------------------------- | ------------------- |
| `FAV_WIDGET_KEY`       | Key binding                                                                                                                       | `^[v` (alt-v)       |
| `FAV_FILE`             | Path to the data file                                                                                                             | `$HOME/.fav`        |
| `FAV_FZF_OPTS`         | Extra `fzf` string/array of options to override the `FZF_DEFAULT_OPTS` (see `man fzf /options`)                                   | `()`                |
| `FAV_DIR_PREVIEW_CMD`  | Command used to populate the `fzf` preview panel for dirs                                                                         | `exa | ls`          |
| `FAV_FILE_PREVIEW_CMD` | Command used to populate the `fzf` preview panel for files                                                                        | `bat | less | more` |
| `FAV_ENABLE_ICONS`     | Enable icons from fonts like [Nerd Fonts](https://www.nerdfonts.com) (true\|false)                                                | `false`             |
| `FAV_DIR_ICON`         | Icon string for dirs                                                                                                              | `D`                 |
| `FAV_FILE_ICON`        | Icon string for files                                                                                                             | `F`                 |
| `FAV_UNKNOWN_ICON`     | Icon string for unknown paths                                                                                                     | `?`                 |
| `FAV_ORDER`            | Keep the favorite list ordered by `-type`, `-name`, `-path` or `-time` or reversed with `-rtype`, `-rname`, `-rpath` or `-rtime`. | `-time`             |

## License

This software is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

---

Copyright &copy; 2020 Domizio Demichelis
