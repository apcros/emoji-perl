package Emoji;

use utf8;
use strict;
use warnings;

# Core since 5.18
use File::Temp qw/ tempfile /;

# Separate sub just in case we decide to do some crazy shit
# Like fetching from a web service
sub get_grammar {
	return (
	"⌚" => "time",
	"✅" => ";", #✅
	"⚓" => "sub",
	"▶" => "{",
	"◀" => "}",
	"📌" => "my",
	"💲" => "\$",
	"⏪" => "=",
	"🔼" => "shift",
	"📠" => "print",
	"✴" => "\"",
	"🔹" => ".",
	"💩" => "use Data::Dumper; print Dumper",
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
    my $emoji_file = shift;

    my ($fh, $perl_file) = tempfile();
    binmode($fh, ":utf8");

    my $emoji_code = slurp($emoji_file);
    my $perl_code = emoji_to_perl($emoji_code);
    print $fh $perl_code;

    return `perl $perl_file`;
}

sub slurp {
    my $file = shift;
    open my $fh, '<:encoding(UTF-8)', $file or die;
    local $/ = undef;
    my $cont = <$fh>;
    close $fh;
    return $cont;
}

1;
