# gadgets-tar

Tar for the gadgets of [polpo](https://github.com/polpo-system/polpo): a tar archive as a document,
the list of its files, from which some or all can be extracted. polpo's console has its own tar
(the package tar) for making archives.

```
portia.Install gadgets-tar
```

## Using

    Desktops.OpenDoc Archive.tar (Tar.NewDoc)    the archive as a document
    Tar.Extract, Tar.ExtractAll                   (in its menu) the selected files, or all

## What is here

    src/Tar.Mod          the document
    tools/TarDocs.Tool
    test/TarTest.Mod

Tar is by Jacques Supcik. The source comes from ETH Linux Oberon (OLR, 2017-06-18), converted from an Oberon text to plain
text; the first commit has it unchanged. It compiles unchanged with all five of polpo's compilers
(x86, ARM, ARMv7, RISC-V, MIPS).

## Tests

    TarTest.Run      2 checks: the module loaded, a small archive written and opened; it needs the
                     desktop's display

The license is GPL-3 (`LICENSE`); the code comes from ETH Oberon, whose license (`LICENSE.ETH`)
asks to keep its copyright notice and conditions, which `LICENSE.ETH` does.
