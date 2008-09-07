#!/usr/bin/env python
import os, shutil
from optparse import OptionParser

def bad(filename):
    return '_' in filename

def fix(filename):
    (name, ext) = os.path.splitext(filename)
    return name.replace('_', ' ').strip() + ext

def fix_dir(dirname, rename, process_files, process_dirs):
    for dir, dirs, files in os.walk(dirname):
        fs = filter(bad, files)
        ds = filter(bad, dirs)
        if not ((process_files and fs) or (process_dirs and ds)):
            continue
        print "%s:" % dir
        for d in ds:
            dd = fix(d)
            if process_dirs:
                print '\t%s => %s' % (d, dd)
            if rename:
                try:
                    shutil.move(os.path.join(dir, d), os.path.join(dir, dd))
                except IOError:
                    print "\tCan't move!"
                dirs[dirs.index(d)] = dd

        for f in fs:
            ff = fix(f)
            if process_files:
                print '\t%s => %s' % (f, ff)
            if rename:
                try:
                    shutil.move(os.path.join(dir, f), os.path.join(dir, ff))
                except IOError:
                    print "\tCan't move!"

        print

parser = OptionParser()
parser.add_option('-d', '--dirs', help='process dirs', dest='process_dirs', action='store_true')
parser.add_option('-f', '--files', help='process files', dest='process_files', action='store_true')
parser.add_option('-r', '--rename', help='do rename', dest='rename', action='store_true')
(opts, args) = parser.parse_args()

dirs = args
if not len(dirs): dirs = [os.getcwd()]

map(lambda x: fix_dir(x, opts.rename, opts.process_files, opts.process_dirs), dirs)
