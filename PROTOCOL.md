# WinterOS Frost64 Firmware Protocol

The protocol is a really simple one, it just has a table of functions (at the time of writing this).

| Address              | Name  | Args                                            | Note                                                |
|----------------------|-------|-------------------------------------------------|-----------------------------------------------------|
| 0x08 * 0 + WFPT_BASE | Print | r0 = Pointer to source string (null-terminated) | Prints out the source string to the console device. |