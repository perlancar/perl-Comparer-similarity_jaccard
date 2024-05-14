package Comparer::similarity_jaccard;

use 5.010001;
use strict;
use warnings;

use Set::Similarity::Jaccard;

# AUTHORITY
# DATE
# DIST
# VERSION

sub meta {
    return +{
        v => 1,
        args => {
            string => {schema=>'str*', req=>1},
            reverse => {schema => 'bool*'},
            ci => {schema => 'bool*'},
        },
    };
}

sub gen_comparer {
    my %args = @_;

    my $string = $args{string};
    my $lc_string = lc $string;
    my $reverse = $args{reverse};
    my $ci = $args{ci};

    my $jaccard = Set::Similarity::Jaccard->new;

    sub {
        my $s = $ci ? $jaccard->similarity($lc_string, lc($_[0])) : $jaccard->similarity($string, $_[0]);
        $reverse ? $s : (1-$s);
    };
}

1;
# ABSTRACT: Compare Jaccard coefficient of a string to a reference string

=for Pod::Coverage ^(meta|gen_comparer)$

=head1 SYNOPSIS

 use Comparer::similarity_jaccard;

 my $cmp = Comparer::similarity_jaccard::gen_comparer(string => 'foo');
 my @sorted = sort { $cmp->($a,$b) } "food", "foolish", "foo", "bar";
 # => ("foo","food","bar","foolish")


=head1 DESCRIPTION

=cut
