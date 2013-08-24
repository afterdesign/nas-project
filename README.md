# Project NAS-BOX

So I wanted a simple NAS. And I was one step before buying "all-in-one" solution from Synology (or smth similar). 
But the price was quite high for what I wanted to do with it.

About 500€ to be exact. Well quick google about parts and there it was. I can do the same (or even better) 
with half the price. So here it is.

First tests are saying that with sleeping HDDs my NAS is using about 26-28W of energy. On start it's using about 
70W and during all HDDs not sleeping 45-50W.
I think it's quite good result but I would like to test it more with better hardware to measure "hunger for power".

## TODO
1. XBMC - [awesome post about xbmc with amd platform](http://forum.xbmc.org/showthread.php?tid=116996)
2. Printer (quite easy task)
3. iTunes music server (cause I have tons of ripped CDs and only 256GB SSD in my laptop)

## Hardware:
+ [Fractal Design 304 case](http://www.fractal-design.com/?view=product&category=2&prod=94) - 6 HDD small chassie. Hard to manage cables but it looks nice and it's working.
+ [OCZ-ZT550W modular PSU](http://ocz.com/consumer/psu/zt-series-550w-750w-power-supply) - I had some minor problems with cable management but looks like it's working
+ DDR3 8GB/1333 CL9 HyperX Blu (cheapest one IIRC)
+ [Gigabyte GA-E350N motherboard](http://www.gigabyte.us/products/product-page.aspx?pid=4264) with integrated dual core 1.6GHz CPU and AMD Radeon HD 6310 graphics.

## Brother Scanning

I have Brother DCP-7030 and those scripts are prepared to work with **brscan3 models**)
In "brother" directory you can find scripts that I hacked to use hardware options to do what I want them to do (scan to tiff, pdf, merge multipages only with scanner) ;)


### Dependencies:
+ libtiff-tools (for tiff2pdf)
+ poppler-utils (for pdfunite)
+ sane-utils (for scanimage)
+ [brscan3 64bit](http://welcome.solutions.brother.com/bsc/public_s/id/linux/en/download_scn.html#brscan3)
+ [scan-key-tool 64bit](http://welcome.solutions.brother.com/bsc/public_s/id/linux/en/download_scn.html#brscan3)

### Missing stuff:
#### Copy stuff
[Brother manual](http://welcome.solutions.brother.com/bsc/public_s/id/linux/en/faq_scn.html#f00101)

```
For brscan3 Users:
/usr/lib64/libbrscandec3.so.1.0.0
/usr/lib64/sane/libsane-brother3.so.1.0.7
/usr/lib64/sane/libsane-brother3.so.1
/usr/lib64/sane/libsane-brother3.so
/usr/lib64/libbrscandec3.so
/usr/lib64/libbrscandec3.so.1
```

#### Update udev
[Brother manual](http://welcome.solutions.brother.com/bsc/public_s/id/linux/en/instruction_scn1c.html#u13.04)

Now for Ubuntu 10.10 and above there is .deb with udev file/rules.
But still that didn't work for me out of the box.
All I needed to do is unhash lines in ```/etc/udev/rules.d/40-brother-libsane-type1.rules```:

```
MODE="0666"
GROUP="scanner"
ENV{libsane_matched}="yes"
SYMLINK+="scanner-%k"
```

#### Update cfg
To use ```bash``` instead of ```sh``` edit ```/etc/opt/brother/scanner/brscan-skey/brscan-skey-0.2.4-0.cfg``` and update:

```
IMAGE="bash  /opt/brother/scanner/brscan-skey/script/scantoimage-0.2.4-0.sh"
OCR="bash  /opt/brother/scanner/brscan-skey/script/scantoocr-0.2.4-0.sh"
EMAIL="bash  /opt/brother/scanner/brscan-skey/script/scantoemail-0.2.4-0.sh"
FILE="bash  /opt/brother/scanner/brscan-skey/script/scantofile-0.2.4-0.sh"
```

### Modes

#### Scan to image

I'm using this to scan multiple pages.

1. just plain scan to tiff

#### Scan to file

I'm using this If I scanned multiple pages document and next document is single page. Also It can be used as single 

1. search for *.tiff files in ```$SCAN_PATH```, convert them to PDF and merge to one pdf, delete all tiffs
2. scan current document to tiff
3. convert new single scan to pdf
4. delete original tiff

#### Scan to e-mail

I'm using this when I scanned multiple pages document (and now it's time to convert it to pdf) 
and I'm going to scan another multipage document.

1. search for *.tiff files in ```$SCAN_PATH```, convert them to PDF and merge.
2. scan current document to tiff (no convertion to pdf)

#### Scan to ocr

This one is new. Just plain merge of multiple pages document.
This task may hang a minute before you can scan more with hardware button, use cancel and stop on 
printer/scanner to stop after merging.

1. search for *.tiff files in ```$SCAN_PATH```, convert them to PDF and merge.
2. no scanning 


## Sleeping disks

In directory ```laptop-mode-tools``` you can find my config for laptop-mode. With this settings all of 
my HDDs are sleeping after few minutes and they are spinning up when needed (watching a movie, scanning 
or making backup).

I tried to set up this using trial and error.

## Mac OS timemachine backup

In directory ```netatalk``` you can find my configs to use one of my HDDs in my linux box as backup.

I'm using netatalk also to share scans to my mac (I'm managing scans with Evernote)

# License

Licensed under the [MIT license](http://opensource.org/licenses/MIT).
