#!/usr/bin/env perl

# xz testbench - run a few iterations of xz with different thread counts

use Getopt::Long;
use Time::HiRes;

sub delete_file {
	my $delete = shift;
	my $delete_ext = "$delete.xz";
	unlink $delete_ext;
}

sub run {
	my $threads = shift;
	my $file = shift;
	my $xz_flags = shift;
	my $cmd = "xz --keep $xz_flags -T$threads $file";
#	print "Running with $threads threads on $file\n";
	my $pid = fork();
	if ($pid == 0) { # child forks again to run xz
#		print "$cmd\n";
		my $r = [Time::HiRes::gettimeofday()];
		system($cmd);
		($u, $s, $cu, $cs) = times;
		my $rdiff = Time::HiRes::tv_interval($r);
		print "$file\t$threads\t$rdiff\t$cs\t$cu\n";
		exit;
	} else { # parent needs to block on child
		waitpid($pid, 0);
	}
}

my @thread_count;
my @files;
my $xz_flags = "";

GetOptions('thread|t=i' => \@thread_count,
	'file|f=s' => \@files,
	'flags|a=s' => \$xz_flags);

if (scalar @files < 1) {
	print "No files specified; supply as many -f flags as needed\n";
	exit 1;
}
if (scalar @thread_count < 1) {
	print "No threads specified; supply as many -t flags as needed\n";
	exit 2;
}

print "file\tthreads\treal\tsys\tuser\n";

foreach my $file (@files) {
	foreach my $threads (@thread_count) {
		delete_file($file);
		run($threads, $file, $xz_flags);
		delete_file($file);
	}
}
