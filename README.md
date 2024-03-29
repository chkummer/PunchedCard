# PunchedCard
Creating IBM 80-column [Punched Cards](https://en.wikipedia.org/wiki/Punched_card) using Laser Printer and [Laser Cutter](https://en.wikipedia.org/wiki/Laser_cutting).

The idea came when somebody at the 'Vintage Computer Festival Zurich' showed me the [Virtual Keypunch](https://www.masswerk.at/keypunch/) (by [mass:werk](https://www.masswerk.at/)) to visualize young Java-Programmers how much data for a SOAP-Request/-Response is sent.

Here is a sample Punched Card:
![sample Punched Card created using Keypunch](Fotos/PunchedCard_0001.png)

mass:werk is offering some other Punched Card Services:
* [Virtual Card Read-Punch](https://www.masswerk.at/card-readpunch/)
* [Punch Card Sampler](https://www.masswerk.at/cardsampler/)
* Font Editor for [IBM 026](https://www.masswerk.at/misc/card-punch-typography/editor026.html) or [IBM 029 and 129](https://www.masswerk.at/misc/card-punch-typography/editor.html)

And a nice documetation about [Punched Card Typography — IBM 026, 029, 129](https://www.masswerk.at/misc/card-punch-typography/).

## Script
In order to create your own punched cards you need to have access to:
* (Laser-)Printer
* Laser Cutter or an Scan and Cut Machine (like the Borther ScanNCut)

If you are a Linux or MacOSX user you may use this script without additional software. Depending on your laser cutter software or printer you may require a postscript converter such as Ghostscript on Linux, Preview on MacOSX or any other Vector Graphics Editor. Windows user may use an virtual machine running Linux or use something like [Cygwin](www.cygwin.com).

### Script Usage
The Shell-Script in this repository generates postcript file(s) form a text input file.
```
host:user$ ./punchcard.sh -h
usage: ./punchcard.sh [options]

options are:
 -i <file>      # input file name containing text
 -I <file>      # input file name containing image
 -c <code>      # card coding (default: IBM029)
 -C <corners>   # card corners (default: Left)
 -S             # change from round to square corners
 -t <type>      # card type (default: IBM5081)
 -p <pagesize>  # set output pagesize (default: A4)
 -o <outfile>   # output base file name (default: punchcard)
 -s             # split output
 -D             # output is for documentation
 -a <type>      # align type between printer and lasercutter (none, cross or lshape default: none)
 -h             # this help text

host:user$
```
See the currently implemented [card types](CardTypes.md), [card corners](CardCorners.md),  [card codes](CardCodes.md) and [image input format](ImageInputFormat.md). You may use 'A4', 'Letter' or 'Legal' as page size.

#### Examples
Here are some examples:
* [Text Single Output](Example_Text_SingleOutput.md)
* [Text Split Output](Example_Text_SplitOutput.md)
* [Image Heart](Example_Image_Heart.md)

### Sample Workflow
Here are two examples of an workflow.

#### Single output
This might be an workflow for a single output:
1. create input text file and process it with the script
1. Print the multi page single file (if required: convert it first)
1. Scan and cut it using a machine like the Brother ScanNCut

#### Split output
This might be an workflow for a split output:
1. create input text file and process it with the script using the '-s' option to create a split output.
1. Print the multi page single printer-file (if required: convert it first)
1. Import the single page single cutter-file into your laser-cutter software (if required: convert it first) and cut the corresponding printed page.



## Details, Hints, Tips and Tricks
* [Align Printer and Cutter Coordinates](AlignPrinterAndCutterCoordinates.md)
* [Card Dimensions](CardDimensions.md)

## More information about Punched Cards
There is more information about puched cards here: [ReadMore.md](ReadMore.md)
