#!/bin/sh

## hyphop ##

#= rc.local.d script

logger -t "$0" "$@"

mount /boot

## /dev/loop0 /overlay f2fs rw,lazytime,noatime,background_gc=on,nodiscard,no_heap,user_xattr,inline_xattr,acl,inline_data,inline_dentry,flush_merge,extent_cache,mode=adaptive,active_logs=6,alloc_mode=reuse,fsync_mode=posix 0 0
##
mount -o remount,nodiscard /overlay

