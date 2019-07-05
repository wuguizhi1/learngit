#!/share/software/software/R-3.0_install/R-3.0.1/bin/Rscript
library(getopt)
library(VennDiagram)
#+--------------------
#get options
#第一列：参数的longname，多个字符。
#第二列：参数的shortname，一个字符。
#第三列：参数是必须的，还是可选的，数字：0代表不接参数 ；1代表必须有参数；2代表参数可选。
#第四列：参数的类型。logical；integer；double；complex；character；numeric
#第五列：注释信息，可选。
#+--------------------
spec <- matrix(c(
     'help',     'h',    0, "logical",   "help, venn plot, max 5",
     'inputs',   'i',    1, "character", "input files, (t1.txt,t2.txt,t3.txt or t1.txt:t2.txt:t3.txt), forced.",
     'main',	 'm',	 2, "character", "input main labels, [venn plot]",
     'labels',   'l',    1, "character", "input labels, (T1,T2,T3 or T1:T2:T3), forced.",
     'outfile',  'o',    1, "character", "out png file name, forced."
), byrow = TRUE, ncol = 5)

opt <- getopt(spec)
#+--------------------
# check options
#+--------------------
if ( !is.null(opt$help) | is.null(opt$input) | is.null(opt$outfile) ) {
    cat(getopt(spec, usage=TRUE))
    q(status=1)
}

if ( is.null(opt$main) ){	opt$main = "venn plot"	}
#+--------------------
# main
#+--------------------
today<-Sys.time()
print(today)
labels=c()
files=c()
filesin=unlist(strsplit(opt$input,"[:,]"))
print( "length of filesin:" )
print( length(filesin) )
if ( is.null(opt$labels) ){
	for (i in 1:length(filesin) ){
		if( file.info( filesin[i] )$size != 0 ){
			labels = c( labels, paste0("T",i) )
			files = c(files,filesin[i])
		}else{
			print( paste0(filesin[i], " is null!" ) )
		}
	}
}else{
	labels=unlist(strsplit(opt$labels,"[:,]"))
}
print( "length of files:" )
print( length(files) )

listVenn = list()
for (i in 1:length(files) ){
	if( file.info( filesin[i] )$size == 0 ){
		print( paste0(files[i], " is null!" ) )
 		q(status=1)
	}
	data = read.csv(files[i], header = F, stringsAsFactors = F)
	listVenn[labels[i]] = list(data$V1)
}

venn.diagram( x=listVenn, filename = opt$outfile,
	height = 450, width = 450,resolution =300, imagetype="png", col ="transparent",
	fill = rainbow(length(files)), alpha = 0.5, cex = 0.45, cat.cex = 0.45 )

for (i in 1:(length(files)-1) ){
	datai = read.csv(files[i], header = F, stringsAsFactors = F)
	for (j in (i+1):length(files) ){
		dataj = read.csv(files[j], header = F, stringsAsFactors = F)
		interrs = intersect(datai$V1, dataj$V1)
		print( c(labels[i], files[i]) )
		print( c(labels[j], files[j]) )
		print(interrs)
	}
}

today<-Sys.time()
print(today)

