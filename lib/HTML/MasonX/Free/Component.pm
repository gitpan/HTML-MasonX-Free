use strict;
use warnings;
package HTML::MasonX::Free::Component;
{
  $HTML::MasonX::Free::Component::VERSION = '0.005';
}
use parent 'HTML::Mason::Component::FileBased';
# ABSTRACT: a component with a "main" method, not just a bunch of text


sub new {
  my ($class, %arg) = @_;
  my $default_method_to_call = delete $arg{default_method_to_call} || 'main';
  my $self = $class->SUPER::new(%arg);
  $self->{default_method_to_call} = $default_method_to_call;
  return $self;
}

sub run {
  my $self = shift;
  $self->{mfu_count}++;
  $self->call_method($self->{default_method_to_call} => @_);
}

1;

__END__

=pod

=head1 NAME

HTML::MasonX::Free::Component - a component with a "main" method, not just a bunch of text

=head1 VERSION

version 0.005

=head1 OVERVIEW

In concept, a Mason component is broken down into special blocks (like once,
shared, init), methods, and subcomponents.  When you render a Mason component,
using it as a template, you aren't calling one of its methods or blocks.
Instead, all the stray code and text that was found I<outside> all of those is
concatenated together and run.

This is sort of a mess.

If you use HTML::MasonX::Free::Component as your component class instead,
rendering the component will call its C<main> method instead of all that other
junk.  This component class extends HTML::Mason::Component::FileBased.  If this
is a problem because of your esoteric Mason configuration, don't panic.  Just
read the source.  Seriously, it's tiny.

This component class is meant to work well with
L<HTML::MasonX::Free::Compiler>, which will let you throw a syntax exception if
there's any significant content outside of blocks, and which can apply
C<default_method_to_call> to calls found when compiling.

You can pass a C<default_method_to_call> argument to the constructor for this
class, but it's not all that easy to get where you need it, so maybe you should
stick with the default: C<main>

=head1 AUTHOR

Ricardo Signes <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Ricardo Signes.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
