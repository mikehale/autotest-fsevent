# this file is invoked when the gem is installed
# rubygems expects it to build a gem, so we need to work around that
def emulate_extension_install(extension_name)
  File.open('Makefile', 'w') { |f| f.write "all:\n\ninstall:\n\n" }
  File.open('make', 'w') do |f|
    f.write '#!/bin/sh'
    f.chmod f.stat.mode | 0111
  end
  File.open(extension_name + '.so', 'w') {}
  File.open(extension_name + '.dll', 'w') {}
  File.open('nmake.bat', 'w') { |f| }
end

emulate_extension_install("fsevent")

# do what we really wanted to do
TOPDIR = File.expand_path(File.join('..', '..', '..'))
`mkdir -p #{File.join(TOPDIR, "bin")}`
`CFLAGS='-isysroot /Developer/SDKs/MacOSX10.5.sdk -mmacosx-version-min=10.5' gcc -framework CoreServices -o #{TOPDIR}/bin/fsevent_sleep main.c`