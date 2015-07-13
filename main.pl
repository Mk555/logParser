#/usr/bin/perl

###############################
#	IMPORTS
###############################

#use strict;
use warnings;
no warnings 'uninitialized';
use Getopt::Std;


###############################
#	PARAMS
###############################

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


###############################
#	VARIABLES
###############################

# Levels of error
my $cs_error = "<Error>";
my $cs_warning = "<Warning>";
my $cs_info = "<Notice>";

# Fields of the logs
my $vs_timestamp;
my $vs_level;
my $vs_type;
my $vs_code;
my $vs_description;


#my $cs_files = `ls /home/mk_/DataTest/*.csv` ;
my $vs_cpt = 0;
my $vs_logFile;
my $vs_row;
my @vt_result;
my @vt_files;


###############################
#	CODE
###############################


# Get the path of the files
# Original path : /home/mk_/DataTest/*.csv
@vt_files = glob( $opt_p . "/*" );


#print(@vt_files);


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
		if ( $vs_row =~ m/$cs_error/  ){

#			Save the line in the table
			if ( defined( $opt_h ) ){
				($vs_timestamp, $vs_level, $vs_type, $vs_code, $vs_description) = split( '> <', $vs_row);
				
				# With this line, it prints the file name & the line. It's usefull if you whant to parse multiple log files.
				#$vs_row = $vs_logFile . " : line " . $vs_cpt . " -> " . $vs_level . " : " . $vs_description;
				
				$vs_row = " -> " . $vs_level . " [" . $vs_code . "]  : " . $vs_description;
				
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


