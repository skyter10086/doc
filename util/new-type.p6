#!/usr/bin/env perl6

use v6;

sub MAIN($typename, :$kind='class') {
    my @path-chunks =  $typename.split('::');
    my $filename = @path-chunks.pop ~ '.pod';
    my $path = 'doc/Type';
    for @path-chunks -> $c {
        $path ~= "/$c";
        unless $path.IO.d {
            mkdir $path.IO.mkdir;
        }
    }

    $path ~= "/$filename";

    spurt $path.IO, Q:s:to/TEMPLATE/;
        =begin pod

        =TITLE $kind $typename

        =SUBTITLE ...

            $kind $typename is SuperClass { ... }

        Synopsis goes here

        =head1 Methods

        =head2 method flurb

            method flurb({$typename}:D: *@args --> Str)

        method description here

        =end pod

        # vim: expandtab shiftwidth=4 ft=perl6
        TEMPLATE

    say "'$path' written";
    say "(remember to 'git add $path')";
}

# vim: expandtab shiftwidth=4 ft=perl6
