#/usr/bin/perl

#use strict;
use warnings;
no warnings 'uninitialized';
use Getopt::Std;

# Get the params w/ the std lib

getopts("hvp:");

if ( not defined( $opt_p ) ){
	print( "Please give the path.\n" );
	exit 0;
}

if ( not defined( $opt_v ) ){
	print( "You are not in verbose mode.\n" );
}

if ( defined( $opt_h ) ){
	print( "You are actually in human readable mode.\n" );
}

my $cs_text = "Error";

# Create the variables

#my $cs_files = `ls /home/mk_/DataTest/*.csv` ;
my $vs_cpt = 0;
my $vs_logFile;
my $vs_row;
my @vt_result;
my @vt_files;



# Get the path of the files
# Original path : /home/mk_/DataTest/*.csv
@vt_files = glob( $opt_p );

# Charging the config files (Not the first thing to do)

print( @vt_files );

# Foreach file
foreach ( @vt_files ){

	$vs_logFile = $_;
	$vs_logFile =~ s/ //g;

	# Open the file
	open( LOG_FILE, "<", $vs_logFile )
        	or die "Error : " . $! . " \n - " . $vs_logFile;

# 	Foreach line
	while ( <LOG_FILE> ){
	

		$vs_row = $_;
		
# 		Search the words
		if ( $vs_row =~ m/$cs_text/ ){

#			Save the line in the table
			if ( defined( $opt_h ) ){
				$vs_row = $vs_logFile . " : line " . $vs_cpt . " -> " . $vs_row;
			}
			push( @vt_result, $vs_row );
#			Increment the cpt
#			Maybe store some infos like the name of the file, or the line too

		}
		
		$vs_cpt = $vs_cpt + 1;

	}
	
	close( LOG_FILE );

	$vs_cpt = 0;
	
}


if ( defined( $opt_v ) ){
	print(@vt_result);
}


print( "\n" );

exit( 0 );

# Foreach line of the result :
# 	If the script is in human readable mode, print the line (try to color)
# 	Then print the level of alert (Info/Warn/Crit)
#
# 	If the script is not human readable, print each line like that :
# 	<Error message>|<Level of alert 0-3>
#
# Release the objects, then return the max level of alert.
#
#
# -- END --
#
# (For now...)
#
#
#
#
#
#
##
