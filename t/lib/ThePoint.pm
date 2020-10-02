use Renard::Incunabula::Common::Setup;
package ThePoint;
# ABSTRACT: Generate a tree

use aliased 'Intertangle::Jacquard::Actor';
use aliased 'Intertangle::Jacquard::Actor::Taffeta::Group';
use aliased 'Intertangle::Jacquard::Actor::Taffeta::Graphics';
use aliased 'Intertangle::Jacquard::Layout::Fixed';
use aliased 'Intertangle::Jacquard::Layout::All';
use aliased 'Intertangle::Jacquard::Layout::Affine2D';
use aliased 'Intertangle::Jacquard::Layout::AutofillGrid';
use aliased 'Intertangle::Jacquard::Layout::Composed';
use aliased 'Intertangle::Jacquard::Content::Rectangle';
use Intertangle::Taffeta::Color::Named;
use Intertangle::Taffeta::Style::Fill;
use Intertangle::Taffeta::Style::Stroke;
use Intertangle::Taffeta::Transform::Affine2D::Scaling;
use Intertangle::Jacquard::Graph::Taffeta;

use Moo;

#use Log::Any::Adapter;
#Log::Any::Adapter->set('Stdout',
	##min_level => 'trace',
	##use_color => 1, # force color even when not interactive
	## stderr    => 0, # print to STDOUT instead of the default STDERR
#);

fun create_page_node( :$fill = 'svg:black' ) {
	my $page_group = Group->new(
		layout => Fixed->new
	);

	my $rect = Rectangle->new(
		width  => 100,
		height => 200,
		fill   => Intertangle::Taffeta::Style::Fill->new(
			color => Intertangle::Taffeta::Color::Named->new( name => $fill ),
		),
		stroke => Intertangle::Taffeta::Style::Stroke->new(
			color => Intertangle::Taffeta::Color::Named->new( name => 'svg:blue' ),
		),
	);
	$page_group->add_child(
		Graphics->new(
			content => $rect,
		),
		layout => {
			x => 0,
			y => 0,
		},
	);

	if(1){#DEBUG
	my $sz = 25;
	$page_group->add_child(
		Graphics->new(
			content => Rectangle->new(
				width => $sz,
				height => $sz,
				fill => Intertangle::Taffeta::Style::Fill->new(
					color => Intertangle::Taffeta::Color::Named->new( name => 'svg:red' ),
				),
			),
		),
		layout => {
			x => 0,
			y => 0,
		},
	);

	$page_group->add_child(
		Graphics->new(
			content => Rectangle->new(
				width => $sz,
				height => $sz,
				fill => Intertangle::Taffeta::Style::Fill->new(
					color => Intertangle::Taffeta::Color::Named->new( name => 'svg:red' ),
				),
			),
		),
		layout => {
			x => $rect->bounds->size->width  - $sz,
			y => $rect->bounds->size->height - $sz,
		},
	);
	}

	$page_group;

}

sub composed_affine_actor {
	my (%args) = @_;

	#my $affine = Group->new(
		#layout => Affine2D->new( transform =>
				#Intertangle::Taffeta::Transform::Affine2D
				#->new(
					##%args
				#)
		#),
	#);
	#my $grid = Group->new(
		#layout => AutofillGrid->new(
			#rows => 2,
			##intergrid_space_rows => 50,
			##intergrid_space_columns => 10,
			#columns => 2,
		#),
	#);

	#$affine->add_child($grid);

	#return $affine;

	return Group->new(
		layout => Composed->new(
			layouts => [
				All->new,
				(
				Affine2D->new( transform =>
					Intertangle::Taffeta::Transform::Affine2D
						->new(
							%args
						)
				),
				)x(0),
				(
				AutofillGrid->new(
					rows => 2,
					#intergrid_space_rows => 50,
					#intergrid_space_columns => 10,
					columns => 2,
				),
				)x(1),#DEBUG
			],
		)
	);
}

method graph() {
	#my $root = Group->new(
		#layout => Composed->new(
			#layouts => [
				#All->new,
				#Affine2D->new( transform =>
					#Intertangle::Taffeta::Transform::Affine2D::Scaling
						#->new(
							#scale => [1.2, 1.2],
						#)
				#),
				#AutofillGrid->new(
					#rows => 4,
					#intergrid_space => 50,
					#columns => 1,
				#),
			#],
		#)
	#);
	my $top = Group->new(
		layout => Affine2D->new( transform =>
			Intertangle::Taffeta::Transform::Affine2D::Scaling
				->new(
					scale => [0.2, 0.2],
				)
		),
	);
	my $root =  Group->new(
		layout => AutofillGrid->new(
			rows => 2,
			intergrid_space => 50,
			columns => 2,
		),
	);
	$top->add_child($root);

	#my $left  = composed_affine_actor( matrix_xy => { xx => 2   , yy => 0.5 } );
	#my $right = composed_affine_actor( matrix_xy => { xx => 1   , yy => 0.9 } );
	#my $one   = composed_affine_actor( matrix_xy => { xx => 2.5 , yy => 0.7 } );
	#my $two   = composed_affine_actor( matrix_xy => { xx => 1   , yy => 1.0 } );

	my $left  = composed_affine_actor( matrix_xy => { xx => 1   , yy => 1.0 } );
	my $right = composed_affine_actor( matrix_xy => { xx => 1   , yy => 1.0 } );
	my $one   = composed_affine_actor( matrix_xy => { xx => 1.0 , yy => 1.0 } );
	my $two   = composed_affine_actor( matrix_xy => { xx => 1   , yy => 1.0 } );

	$root->add_child( $left );
	$root->add_child( $right );
	$root->add_child( $one );
	$root->add_child( $two );

	$left->add_child(  create_page_node( fill => $_ ) ) for qw(svg:blue      svg:yellow   svg:magenta);
	$right->add_child( create_page_node( fill => $_ ) ) for qw(svg:green     svg:cyan     svg:darksalmon);
	$one->add_child(   create_page_node( fill => $_ ) ) for qw(svg:firebrick svg:gold     svg:darkorchid);
	$two->add_child(   create_page_node( fill => $_ ) ) for qw(svg:honeydew  svg:seagreen svg:limegreen);

	my $states = $root->layout->update( state => Intertangle::Jacquard::Render::State->new );
	#use DDP; p $states, class => { expand => 'all' };
	#use DDP; p $root->layout->layouts->[1];

	#return $top; # TODO
	return Intertangle::Jacquard::Graph::Taffeta->new(
		graph => $root,
	)
}

with qw(Intertangle::Boteh::Role::Sceneable);

1;
