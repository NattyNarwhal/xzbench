This program will run xz with the specified files (`-f` flags) and threads
(`-t` flags; 0 for all cores xz can find). There can be multiple of each flags
specified. The values are tab-seperated for easy formatting.

Should run on Perl 5.10 (maybe older if the modules are there) with
`Time::HiRes` and `Getopt::Long`.

# TODO

* Automatically detect proc/core/thread hierarchy if no `-t` given

* Don't double-fork. Count times from parent. This means we could do averages.

* Avoid writing necessary; write to unattached stdio or null.

# Links

* [Corpus we use](http://mattmahoney.net/dc/textdata.html)
* [tsundoku's results](https://wiki.tsundoku.ne.jp/XZ_%E5%9C%A7%E7%B8%AE%E8%A9%A6%E9%A8%93)
* [John's results](https://ljck.org/doku.php?id=xzbench)
