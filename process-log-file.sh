#!/usr/bin/perl

($day, $month, $year) = (localtime)[3,4,5];
$filename=$ENV{'TASKID'} . ".log";

open my $info, $filename or die "Could not open $filename: $!";

while( my $line = <$info>)  {
    if ($line =~ m/\{.+\}/)
    {
        print "$line";
    }
}
close $info;

