# PunchedCard
Creating IBM 80-column [Punched Cards](https://en.wikipedia.org/wiki/Punched_card) using Laser Printer and [Laser Cutter](https://en.wikipedia.org/wiki/Laser_cutting).

The idea came when somebody at the 'Vintage Computer Festival Zurich' showed me the [Virtual Keypunch](https://www.masswerk.at/keypunch/) (by [mass:werk](https://www.masswerk.at/)) to visualize young Java-Programmers how much data for a SOAP-Request/-Response is sent.

Here is a sample Punched Card:
![sample Punched Card created using Keypunch](Fotos/PunchedCard_0001.png)

mass:werk is offering some other Punched Card Services:
* [Virtual Card Read-Punch](https://www.masswerk.at/card-readpunch/)
* [Punch Card Sampler](https://www.masswerk.at/cardsampler/)

And a nice documetation about [Punched Card Typography — IBM 026, 029, 129](https://www.masswerk.at/misc/card-punch-typography/).

Other Punch Card Services:
* [Cardpunch: punch a punched card](http://www.kloth.net/services/cardpunch.php)

More information about Punched Cards:
* [The Punched Card](http://www.quadibloc.com/comp/cardint.htm)
* [Punched Card Codes](http://homepage.divms.uiowa.edu/~jones/cards/codes.html) (Part of [ Douglas W. Jones Punched Card Collection](http://homepage.divms.uiowa.edu/~jones/cards/index.html))
* [The Design of IBM Cards](http://bitsavers.org/pdf/ibm/punchedCard/Training/22-5526-4_The_Design_of_IBM_Cards_Mar56.pdf)
* German Wikipedia-Article: [Lochkarte](https://de.wikipedia.org/wiki/Lochkarte)
* YouTube-Video: [1964 IBM 029 Keypunch Card Punching Demonstration](https://www.youtube.com/watch?v=YnnGbcM-H8c)
* YouTube-Video: [Punch Card Programming - Computerphile](https://www.youtube.com/watch?v=KG2M4ttzBnY)
* YouTube-Video: [Computer Punch Cards Historical Overview - IBM Remington Rand UNIVAC - History Archives, # CH-0093](https://www.youtube.com/watch?v=kKJxzay85Vk)

Standards:
* ANSI INCITS 21-1967 (R2002): Rectangular Holes in Twelve-Row Punched 
* ISO 1681:1973(en): Information processing - Unpunched paper cards - Specification
* ISO 6586:1980(en): Data processing — Implementation of the ISO 7- bit and 8- bit coded character sets on punched cards

## Align Printer and Cutter Coordinates
I try to align it using the lasercutter absolute coordinates and adjusting the offset in the lasercutter software (in this case [LightBurn](https://lightburnsoftware.com/)):
![screenshot of LightBurn lasercutter software](Fotos/PunchedCard_0002.png)

Print the [offsetTestPage](Files/offsetTestPage_A4.pdf) to Paper place the paper in to the lasercutter using some sort of mechanical alignment:
![place paper in the lasercutter](Fotos/PunchedCard_0003.jpg)

Measure offset with a ruler. Adjust offset in the lasercutter software. Repeat test/measure/adjust until the cuts match the red crosses:
![measure offset with ruler](Fotos/PunchedCard_0004.jpg)
