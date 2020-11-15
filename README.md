# fav

`zsh`/`fzf` plugin that makes it really easy to add and recall named favorites of your important directories.

## Usage

Add arbitrary named favorites of any current dir:

```
~/repos/dd/oss/docker/files $ fav+ docf
[ADDED]  docf  ->  /home/dd/repos/dd/oss/docker/files

/opt/vivaldi/resources/vivaldi/hooks $ fav+ vivh
[ADDED]  vivh  ->  /opt/vivaldi/resources/vivaldi/hooks
```

If you don't pass an explicit name, `fav` generates one based on the `basename $PWD`:

```
~/repos/dd/oss/ruby/pagy $ fav+
[ADDED]  pagy  ->  /home/dd/repos/dd/oss/ruby/pagy
```

Use the saved `fav` names in place of the actual dirs:

```
~ $ cd ~pagy           # normal cd
~ $ ~pagy              # cd with AUTO_CD
~ $ ~pa<tab><enter>    # completes ~pagy and cd to it
~ $ pagy               # cd with AUTO_CD + CDABLE_VARS
~ $ pagy/lib/extras    # cd with AUTO_CD + CDABLE_VARS in sub-path
```

Use the `fzf` widget to search the favs and insert in the `ZLE` buffer:

```
~ $ ls <alt-v>
<pick one or more favs with fzf>
~ $ ls ~docf ~pagy
...
```

Remove named fav(s):

```
~ $ fav- doc     # autocompletes if only one matches or opens fzf panel
[REMOVED]  docf  ->  /home/dd/repos/dd/oss/docker/files
```

Remove with fzf panel:

```
~ $ fav-
<pick one or more favs with fzf>
[REMOVED]  vivh  ->  /opt/vivaldi/resources/vivaldi/hooks
```

List the missing favs (??) not pointing to any dir anymore:

```
~ $ fav?
2  old    ??  /path/old
3  older  ??  /path/older
```

Remove all the missing favs with a sigle command:

```
~ $ fav?-
[REMOVED]  old    ??  /path/old
[REMOVED]  older  ??  /path/older
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

| Command         | Action                                                                                                                                       |
| --------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| `fav+ [NAME]`   | Add current dir as `NAME`. If missing, `NAME` is generated based on `basename $PWD`                                                          |
| `~NAME`         | Generated alias that expands to full favorite path, internally declared with `hash -d NAME=/favorite/path` (see `man zshbuiltins` /hash)     |
| `fav- [STRING]` | Remove fav(s): matches otpional `STRING` to fav `NAME` and removes it if single match. Multiple matches or no `STRING` open the `fzf` panel  |
| `fav?`          | Shows list of all the missing (??) favs                                                                                                      |
| `fav?-`         | Removes all the missing (??) favs                                                                                                            |
| `alt-v`         | Default `FAV_KEY` binding to the `fav::widget`. It opens the `fzf` panel listing all favs. It insert the selected favs into the `ZLE` buffer |

## Options

| Variable               | Description                                                                                                 |
| ---------------------- | ----------------------------------------------------------------------------------------------------------- |
| `FAV_KEY`              | Key binding: default `^[v` (alt-v)                                                                          |
| `FAV_FILE`             | Path to the data file: default `$HOME/.fav`                                                                 |
| `FAV_FZF_PREVIEW`      | Command used to populate the `fzf` preview panel with `ls` or `exa`. Set it to `''` to disable the preview |
| `FAV_FZF_OPTS`         | `fav` extra `fzf` options to override the `FZF_DEFAULT_OPTS` (see `man fzf /options`)                       |
| `FAV_COLORIZE_MISSING` | Colorize the missing favs (??) in the `fzf` panel list. Set it to `never` to disable it                     |

## License

This software is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

---

Copyright &copy; 2020 Domizio Demichelis
