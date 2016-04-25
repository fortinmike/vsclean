# vsclean

A recursive delete of temporary Visual Studio and ReSharper output files, vsclean performs.

## Installation:

    $ gem install vsclean

## Usage:

Note: Use `--dry-run` to simulate deletion first, for more safety.

### Local Cleanup

    $ vsclean

- Deletes `**/{bin,obj}`
- Deletes `**/.vs/**/.suo`

### Global Cleanup

    $ vsclean --global

- Deletes `~/AppData/Local/JetBrains/**/SolutionCaches`
- Deletes `~/AppData/Microsoft/WebsiteCache`
- Deletes `~//AppData/Local/Microsoft/**/ComponentModelCache`

### Full Cleanup

    $ vsclean --full
    
- Deletes all local and global temporary files and directories 
