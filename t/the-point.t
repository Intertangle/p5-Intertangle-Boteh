#!/usr/bin/env perl

use Test::Most tests => 1;
use Test::Needs qw(SVG Data::Printer);
use lib 't/lib';

use Renard::Incunabula::Common::Setup;
use Path::Tiny;
use ThePoint;

subtest "What is the point?" => sub {
	use Carp::Always;
	my $graph = ThePoint->graph;

	my $file = Path::Tiny->tempfile;

	my $svg = $graph->to_render_graph->to_svg;

	$file->spew_utf8( $svg->xmlify );

	#use DDP; p $tree, class => { expand => 'all' };

	pass;
};

done_testing;
