package Emoji;

use File::Slurp;
use utf8;
use strict;
use warnings;

# Separate sub just in case we decide to do some crazy shit
# Like fetching from a web service
sub get_grammar {
	return (
	"\xE2\x8C\x9A" => "time",
	"\xE2\x9C\x85" => ";", #✅
	"\xE2\x9A\x93" => "sub",
	"\xE2\x96\xB6" => "{",
	"\xE2\x97\x80" => "}",
	"\xF0\x9F\x93\x8C" => "my",
	"\xF0\x9F\x92\xB2" => "\$",
	"\xE2\x8F\xAA" => "=",
	"\xF0\x9F\x94\xBC" => "shift",
	"\xF0\x9F\x93\xA0" => "print",
	"\xE2\x9C\xB4" => "\"",
	"\xF0\x9F\x94\xB9" => ".",
	"\xF0\x9F\x92\xA9" => "use Data::Dumper; print Dumper",
	);
}

sub emoji_to_perl {
	my $source = shift;
	my %emoji_grammar = get_grammar();

	foreach my $emoji (keys %emoji_grammar) {
	$source =~ s/$emoji/$emoji_grammar{$emoji}/g;
	}
	return $source;
}

sub do_magic {
	my $file_path = shift;
	my $emoji_source = File::Slurp::read_file($file_path);

	File::Slurp::write_file($file_path.".bytecode",emoji_to_perl($emoji_source));
	my $executed_emoji =  `perl $file_path.bytecode`;
	unlink "$file_path.bytecode";
	return $executed_emoji;
}

1;