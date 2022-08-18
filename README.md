# Img_to_Hex

This script was designed to take a png and convert it to a text file.

The textfile is an ordered list of its pixels' hexadecimal values.

By default the alpha channel is ignored and each value is comma separated with no newlines.

Additionally, the default transparent pixel behaviour is to represent it with the decimal number 1.
This is necessary since otherwise every transparent pixel would become black without the alpha channel.

Options may be added in the future for different formats but that is not a priority.

Its sole argument should be the name of your png file without the extension.
