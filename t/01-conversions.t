use strict;
use warnings;

use Test::More tests => 9;
use Image::JpegTran;

#testimg.jpg
#testimgp.jpg
#testorig.jpg
#testprog.jpg

for my $opts (
	{ r => 1, rotate => 90 },
	{ r => 1, rotate => 180 },
	{ r => 1, rotate => 270 },
	{ r => 0, rotate => 91 },
	{ r => 1, rotate => 90, trim => 1, copy => 'all' },
	{ r => 1, rotate => 90, trim => 0, copy => 'none' },
	{ r => 0, rotate => 90, perfect => 1 },
	{ r => 1, rotate => 90, optimize => 1, progressive => 1 },
	{ r => 1, rotate => 90, arithmetic => 1 },
) {
	my $result = delete $opts->{r};
	my $rc = eval{
		Image::JpegTran::_jpegtran(
			"t/data/testimg.jpg",
			"t/data/out.jpg",
			$opts,
		);
		1;
	};
	if ($result) {
		ok $rc, "ok: @{[ %$opts ]}";
	}
	else {
		diag "$@";
		ok !$rc, "bad: @{[ %$opts ]}";
	}
};

END {
	-e 't/data/out.jpg' and unlink 't/data/out.jpg';
}
