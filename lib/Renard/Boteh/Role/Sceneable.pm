use Renard::Incunabula::Common::Setup;
package Renard::Boteh::Role::Sceneable;
# ABSTRACT: A role for a scenes

use Moo::Role;
use Renard::Jacquard::Types qw(Actor);

has tree => (
	is => 'rw',
	isa => Actor,
);

1;
