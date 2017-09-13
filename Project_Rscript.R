#------------------------------------------------------------------------
#-----Begin of Datacleaning - crime 2011 & Crime 2012-2015 --------------
#------------------------------------------------------------------------  
 dataclean_colnames<-function(x,y,i,type)
 {
    browser();
    if (type == 1)
    {
      colnames(y[i]) <- colnames(x[i]);  
    }
    #rm(type);
    return(y);
 } 
 dateclean<-function(ds) {
   
   ds<-separate(ds,Date.Rptd,c('Date','Time','Am'),sep = ' ')
   col<-c(-2:-3)
   ds<-deletecol(ds,col)
   ds<-separate(ds,Date,c('d1','d2','Date'),sep = '/')
   col<-c(-1:-2)
   ds<-deletecol(ds,col)
   ds$Date<-str_pad(ds$Date,8,side = "left",pad = "0")
   ds<-separate(ds,Date,c('d1','d2'),sep = 2:2)
   ds<-separate(ds,d2,c('d2','d3'),sep = 2:2)
   ds<-unite(ds,Date.Rptd,d1,d2,d3,sep = '/')
   
   ds<-separate(ds,DATE.OCC,c('DATE.OCC','Time'),sep = ' ')
   col<--4;
   ds<-deletecol(ds,col)
   browser();
   return(ds);
 }
 deletecol<-function(ds,cols)
 {
   #browser();
   ds<-ds[,cols]
   return(ds);
   rm(ds,cols);
 }   
  
 editrow<-function(ds)
 {
   browser();
   i = 1;
   X <- c("TH","UNK");
   while (i <= nrow(ds))
   {
      if(ds$Status[i]=="CC" )
      { 
        if(ds$Status.Desc[i]=="UNK")
        { 
           browser();
           ds$Status.Desc[i]<- "Unknown"; 
           print(ds$Status.Desc[i])
        }
      }
      
     ifelse(ds$Status[i]== X,ds$Status[i]<-"CC",ds$Status[i])
      
     i = i + 1;
   }
   return(ds);
   #rm(ds);
   #browser();
 }   
 grouparea<-function(ds)
 {
   i = 1;
   #browser();
   while (i<=nrow(ds)) 
   {   
     ds$bureau[i]<-" ";
     X <- c(1,2,4,11,13)
     ifelse (ds$AREA[i] == X,ds$bureau[i]<-"Central Bureau"," ")
     X <- c(12,5,18,3)
     ifelse (ds$AREA[i] == X,ds$bureau[i]<-"South Bureau"," ")
     X <- c(19,17,16,15,9,10,21)
     ifelse (ds$AREA[i] == X,ds$bureau[i]<-"Valley Bureau"," ")
     X <- c(6,7,14,8,20)
     ifelse (ds$AREA[i] == X,ds$bureau[i]<-"West Bureau"," ")
     i = i + 1;    	  
   }  
   #rm(X);
   return(ds)
   #browser();
 }
 #------------------------------------------------------------------------
 #-----End of Datacleaning - crime 2011 & Crime 2012-2015 ----------------
 #------------------------------------------------------------------------ 
 #------------------------------------------------------------------------
 #-----Begin of Join two datasets crime 2011 & Crime 2012-2015 -----------
 #------------------------------------------------------------------------ 
 join_dataset<-function(x,y)
 {
   i = 1;
   browser();
   
   if (ncol(x) == ncol(y))
   {
     while (i <= ncol(x))
     {
       if (identical(colnames(x[i]),colnames(y[i])))
       {
         i = i + 1;
       }
       else
       {
         browser();
         column_name <- colnames(x[i]);  
         colnames(y)[i] <- colnames(x[i]);
         #print('Not possible to combine datasets with different column names',i);
         #break;
         i = i + 1;
       }
     }
     z = rbind(x,y);  
   }
   browser();
   return(z);
 }
 #------------------------------------------------------------------------
 #-----End of Join two datasets crime 2011 & Crime 2012-2015 -------------
 #------------------------------------------------------------------------  
 #browser();
 library(dplyr);
 library(tidyr);
 library(plotly);
 library(stringr);
 library(plotrix);
 
 
ds_11<-read.csv("LAPD_Crime_2011_R.csv");
ds_12_15<-read.csv("Crimes_2012-2015_R.csv");

 browser();
 #------------------------------------------------------------------------
 #-----cleaning the date field in LAPD crime 2011 dataset ----------------
 #------------------------------------------------------------------------  
 #ds_11<-dateclean(ds_11);
 #browser();
 #------------------------------------------------------------------------
 #-----joining LAPD crime 2011 dataset & 2012-2015 dataset ---------------
 #------------------------------------------------------------------------  
 
subset1 <- subset(ds_12_15,AREA %in% c(1,2,4,11,13))
 subset2 <- subset(ds_12_15,AREA %in% c(19,17,16,15,9,10,21))
 subset3 <- subset(ds_12_15,AREA %in% c(6,7,14,8,20))
 subset4 <- subset(ds_12_15,AREA %in% c(12,5,18,3))
 subset1<-grouparea(subset1);
 subset2<-grouparea(subset2);
 subset3<-grouparea(subset3);
 subset4<-grouparea(subset4);
 
 
 subset1  <- join_dataset(subset1,subset2);
 subset1  <- join_dataset(subset1,subset3);
 ds_12_15 <- join_dataset(subset1,subset4);
 
 ds_11_15 <- editrow(ds_11_15);
 ds_11_15 <- grouparea(ds_11_15);
 
 View(ds_11_15);
 ds_11_area$Status.Desc <- as.character(ds_11_area$Status.Desc)
 ds_clean11<-editrow(ds_11_area)
 
 ds_11_15 <- join_dataset(ds_clean11,ds_12_15);
 
 ds_final<-ds_11_15
 ds_final$tmpdate <- ds_final$Date.Rptd
 #------------------------------------------------------------------------
 #-----Begin of analysis 1 : No of crimes in each years-
 #------------------------------------------------------------------------  
 ds_final<-separate(ds_final,tmpdate,c('M','D','Y'),sep = '/')
 ds_final<-ds_final[,-17:-18]
 crimecount <- table(ds_final$Y);
 plot(crimecount,type = 'b',ylab='No of Crimes',xlab = 'Years',ylim = c(210000,260000),main="No of Crimes over the years (2011-2015)")
 #------------------------------------------------------------------------
 #-----End of analysis 1 : No of crimes in each years-
 #------------------------------------------------------------------------  
 #------------------------------------------------------------------------
 #-----Begin of analysis 2 : Percentage of Crimes in each Bureau-
 #------------------------------------------------------------------------  
 crimebureau<-table(ds_final$bureau)
 percentcrime<-round((crimebureau/sum(crimebureau))*100,2)
 pielables<-c("Central Bureau","South Bureau","Valley Bureau"," West Bureau");
 pielables<-paste(pielables,":-",percentcrime,sep = " ")
 pielables<-paste(pielables,"%",sep = '')
 pie(crimebureau,labels = pielables,col=rainbow(length(pielables)),main="Percentage of Crimes in each Bureau")
 #------------------------------------------------------------------------
 #-----End of analysis 2 : Percentage of Crimes in each Bureau-
 #------------------------------------------------------------------------
 #------------------------------------------------------------------------
 #-----Begin of analysis 3 : Juvenile Crime pattern over the years-----
 #------------------------------------------------------------------------  
 juvenile<-subset(ds_final,subset = Status %in% c("JA","JO"));
 crimecategory<-table(juvenile$Crime.grp)
 barplot(crimecategory,main="Juvenile Crime Pattern Over the years",xlab="Crime Category",col="plum4",ylim = c(0,3500),ylab = "No of Crimes");
 #------------------------------------------------------------------------
 #-----End of analysis 3 : Juvenile Crime pattern over the years-----
 #------------------------------------------------------------------------
 
 jbureau<-table(juvenile$bureau)
 pielab<-paste(jbureau)
 
 pie3D(jbureau,labels = pielab,explode = 0.1,main="No of Juveile crimes in each bureau")
 pielables<-NULL
 pielables<-c("Central Bureau","South Bureau","Valley Bureau"," West Bureau");
 pielab<-paste(pielables,"\n",pielab)
 pielab<-NULL
 pielab<-paste(pielables,"\n",pielab)
 pielables<-c("Central Bureau","South Bureau","Valley Bureau"," West Bureau");
 pie3D(jbureau,labels = pielab,explode = 0.1,main="No of Juveile crimes in each bureau")
 pielab<-NULL
 pielab<-paste((pielables,"\n",jbureau)
               
               pielab<-paste(pielables,"\n",jbureau)
               pie3D(jbureau,labels = pielab,explode = 0.1,main="No of Juveile crimes in each bureau")
               barplot(crimecategory,main="Juvenile Crime Pattern Over the years",xlab="Crime Category",col="plum4",ylim = c(0,3500),ylab = "No of Crimes");
 