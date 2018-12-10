sub dofile
{
$f=shift;
open(FILI,"<".$f.".java");
open(FILO,">".$f.".h");
@strings=<FILI>;

$all="";
foreach $ii (@strings)
{
 $ii=~s/\/\/.+$//;
 chomp($ii);

 $all.=$ii;
}

 $all=~s/\/\*.+?\*\// /gm;
 $all=~s/\s+/ /gm;
 $all=~s/{/\n{\n/gm;
 $all=~s/}/\n}\n/gm;
 $all=~s/\;/\;\n/gm;
 $all=~s/\n\n/\n/gm;
 $all=~s/\n\s/\n/gm;
 $all=~s/^\s//gm;


@strings=split("\n",$all);

$c=0;
my $ft=0;
foreach $ii (@strings)
{

@ll=("static","public","}","{","interface","extend","import","implement");
  foreach $ss(@ll)
    {
#//     print "ii:".$ii."==".$ss."SSSS";
#     print index($ii,$ss,0);
     if(index($ii,$ss)>-1) {$fl=1;}
     $fl=1;
    }  

 if($ft>7) {$fl=0;}
 if(index($ii,"{")>-1) {$ft+=4;$fl=1;}
 if(index($ii,"}")>-1) {$fl=1;}
 if ($fl==1) {for($u=0;$u<$ft;$u++) {print FILO " ";}}
 if(index($ii,"}")>-1) {$ft-=4;}
if ($fl==1) { 
 print FILO $ii."\n"; }
}

close(FILI);
close(FILO);

}

sub dodir
{
my $r=shift;
my $nj;
print "OPEN=$r\n";
opendir my $dh,$r;
while($file=readdir($dh))
 {
   if( -f $r."\\".$file) 
     { if (index($file,".java")>-1) {  print $file."\n"; $nj=$r."\\".$file; $nj=~s/\.java// ; dofile($nj);  }
     }
   elsif(index($file,".")==-1) { dodir($r."\\".$file);}
 }
closedir($dh);
}

dodir(".");
#$f="sss";
#dofile($f);
