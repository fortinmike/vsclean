# vsclean

A recursive delete of temporary Visual Studio and ReSharper output files, vsclean performs.

## Installation:

    $ gem install vsclean

## Usage:

### Local Cleanup

    $ vsclean

- Deletes `**/{bin,obj}`
- Deletes `**/.vs/**/.suo`
