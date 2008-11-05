import os, sys, glob, optparse

def register_dlls(dir, config, register):
    for root, dirs, files in os.walk(dir):
        printed_dir = False
        dlls = glob.glob(os.path.join(root, "*.dll"))
        for dll in dlls:
            if config and not (config in dll.lower()):
                continue
            if not printed_dir:
                printed_dir = True
                print "%s:" % root
            if register:
                res = not os.system("regsvr32 /s %s" % dll)
                print "\t%s" % ("SUCCEED" if res else "FAILED"),
            print "\t%s" % os.path.basename(dll)

if __name__ == '__main__':
    parser = optparse.OptionParser()
    parser.add_option('-s', '--register', action='store_true', dest="register", default=False)
    parser.add_option('-r', '--release', action='store_true', dest='release', default=False)
    parser.add_option('-d', '--debug', action='store_true', dest='debug', default=False)

    (options, args) = parser.parse_args()
    dirs = args or [os.getcwd()]

    str = None
    if options.release:
        str = "release"
    if options.debug:
        str = "debug"

    for curdir in dirs:
        register_dlls(curdir, str, options.register)
