#Keith Hicks
#CIT 253
#Final Programming

# This program allows a user to select/open a file and perform different options on the file such as
# count number of times a single word appears in the file, print all lines to new file containing that word,
# count number of times a string appears in the file, print all lines to new file containing that string,
# and enter a string and a substitution for that string to replace everywhere it appears in the file and
# print the entire file containing the substitutions to a new file.

use warnings;


#Subroutine opens file for reading, reads all lines of file into an array. Returns the array.

sub openFile
{
  my $filename = shift;
  my @array;
   
  open(FILEIN, '<', "$filename") or die "Couldn't open file $filename for reading, $!";
    
   while (my $line = <FILEIN>)
    {
      chomp($line);
	  
      push @array, $line;	 
	  	 
	}
 
  close FILEIN or die "Cannot close $filename: $!";
	
  return @array;
}

#Subroutine counts occurrences of word/string in file and returns the count.
#Takes the word/string to count, and the array as arguments.

sub countWord
{
  my $word = shift;
  my @lines = @_;
  my $line = $_;
  my $count = 0;
  my $filename;
  
  foreach $line(@lines) 
  {	
   my @occurrences = ($line =~ /\b$word\b/i);
   
   $n = scalar @occurrences;
   $count += $n;
   }
   
  return $count; 
}

#Subroutine finds lines in file with matching word/string writes them to new file. Returns name of new file.
#Takes word/string to find, filename, and array as arguments.

sub searchLine
{
  my $word = shift;
  my $filename = shift;
  my @lines = @_; 
  my $line = $_;
  my @occurrences;
  
  my $filename2 = constNewName($filename);
   
  $okay = open FILEOUT, '>', "$filename2";
   if (! $okay)
     {
    die $filename + " cannot be opened";
     }
	 
  select FILEOUT; 
  
  foreach $line(@lines) 
  {	
   @occurrences = ($line =~ /^.*\b$word\b.*$/gim);
     
   print FILEOUT "@occurrences\n"; 
   }  
   
close FILEOUT;

select STDOUT;  
	   
  return $filename2; 
}

#Subroutine substitutes a word/string in the entire file and writes file with substitutions to new file.
#Returns name of new file.
#Takes word/string to replace, word/string to substitute, filename, and array as arguments.

sub subWords
{
  my $word = shift;
  my $repWord = shift;
  my $filename = shift;
  my @lines = @_; 
  my $line = $_;
  my @occurrences;
  
  my $filename2 = constNewName($filename);
  
  $okay = open FILEOUT, '>', "$filename2";
   if (! $okay)
     {
    die $filename + " cannot be opened";
     }
	 
  select FILEOUT; 
  
  foreach $line(@lines) 
  {
	
   $line =~ s/\b$word\b/$repWord/gim;
    
   print FILEOUT "$line\n"; 
   }  
   
close FILEOUT;

select STDOUT;  
	   
  return $filename2; 
}

#Subroutine takes filename entered by user and appends random number to the end to create new file name.
#Takes the filename as argument.

sub constNewName
{
  my $filename = shift;
  my $newfile;
  my $rand1 = int(rand(100));
  my $find = ".txt";
  my $replace = $rand1.$find;
  
  if(-e $filename)
  {
  $filename = join($replace, split($find, $filename));
  $newfile = $filename.$rand1.$find;
   }
  return $newfile;
}

#Subroutine creates a menu for the user and runs the program.

sub run
{
  my $filename;
  my @array;
  my $words;
  my $lines;
  my $repWord;
  my $selection = '';
  
  print "\nEnter the name of the file you would like to use: ";
  chomp ($filename = <STDIN>);
  print "\n";
  @array = openFile($filename);

  while ($selection ne '5')
  {
     print "\n";
     print "1. Open new file\n".
	       "2. Count a single word or a string\n".
		   "3. Print lines to new file containing a word or string\n".
		   "4. Substitute a string and print to new file\n".
		   "5. Exit\n";
	 print "\n";	   
	 print "Please enter your selection: ";
	 chomp ($selection = <STDIN>);
	 print "\n";
	 
	   if ($selection eq '1')
	      {
		   print "\nEnter the name of the new file: ";
           chomp ($filename = <STDIN>);
	       print "\n";
		   @array = openFile($filename);
	       
           $selection = '';
		   }
	   elsif ($selection eq '2') 
		   {
		      print "\nEnter a word or string to count: ";
              chomp ($word = <STDIN>);
              print "\n";
              $lines = countWord($word, @array);
			
			  print "'$word' was seen $lines times";
			  print "\n";
		    }
	   elsif ($selection eq '3')
			{
			  print "\nEnter a word or string to print mathcing lines to new file: ";
              chomp ($word = <STDIN>);
              print "\n";
              $lines = searchLine($word, $filename, @array);
			  
			  print "The name of the new file is: $lines";
			  print "\n"; 
			} 
	   elsif ($selection eq '4')
			{
			  print "\nEnter a string to replace/substitute: ";
              chomp ($word = <STDIN>);
			  print "\n";
			  
			  print "\nEnter the string to substitute for previous entry: ";
              chomp ($repWord = <STDIN>);
			  print "\n";
			  
			  $lines = subWords($word, $repWord, $filename, @array);
				
			  print "The name of the new file is: $lines";
			  print "\n";
			}
	 }
	 exit(0);
 }


#Main:

run();


   
 
   
   
   