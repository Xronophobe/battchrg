# battchrg


This script provides information about your remaining battery capacity on your **Apple OS X** system while not consuming too much space. It has been designed for being part of your shell prompt.

The point is, using only one character for this purpose. So I ended up with this solution: the only number provided is going to be the number representing the tenths of the remaining battery capacity percentage. Its colors' purpose is to help you determine this percentage slightly more accurately as explained below:


### LEGEND

| SYMBOL   |   MEANING |
|  ---: | --- | 
| CHARACTERS:| |
|    0 - 9  | This number represent the tenths of the remaining capacity (in %) |
|green | Remaining capacity ends in  9 or 8|
|blue  | Ends in 6 or 7|
|white | Ends in 4 or 5|
|yellow| Remaining capacity ends in 2 or 3 |
|red   | Remaining capacity ends in 1 or 0 |
|blinking| Battery level dropped below 20%|
|||
|BACKGROUND:| |
|black | Battery level is above or equal to 30%|
|red   | Battery level dropped to or below 29%.|


 I hope you will find this tool useful. Comments, bugreports are welcome at

          https://github.com/solvskogen-frostlands/battchrg

### Upcoming features:
 - underlined text when charging
 - Linux version
 - since requesting information from `system_profile` is slow and it is being called every time the script is executed (so basically, with every single new prompt), I will implement some options, e.g. only call `system_profile` every given seconds. The best solution would be calling this function only when the remaining capacity has dropped by some arbitrary number.