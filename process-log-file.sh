#!/usr/bin/perl

($day, $month, $year) = (localtime)[3,4,5];
$filename=sprintf("%04d%02d%02d", $year+1900, $month+1, $day) . ".log";

open my $info, $filename or die "Could not open $filename: $!";

while( my $line = <$info>)  {
    if ($line =~ m/\{.+\}/)
    {
        print "$line";
    }
}
close $info;

