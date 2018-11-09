use Renard::Incunabula::Common::Setup;
package Renard::Boteh::Role::Sceneable;
# ABSTRACT: A role for a scenes

use Moo::Role;
use Renard::Incunabula::Common::Types qw(InstanceOf);

has graph => (
	is => 'rw',
	isa => InstanceOf['Renard::Jacquard::Graph::Taffeta'],
);

1;
