PCA_Plot<-function(gene_data_file_path, meta_data_file_path){
  gene_data<-read.csv(gene_data_file_path,sep = ',',stringsAsFactors = FALSE)
  meta_data<-read.csv(meta_data_file_path, sep=',',stringsAsFactors = FALSE)
  rownames(gene_data)<-make.names(gene_data$symbol,unique = TRUE)
  gene_data<-gene_data[,-c(1,2)]
  sample_names<-colnames(gene_data)
  gene_data_t<-as.data.frame(t(gene_data),stringsAsFactors = FALSE )
  gene_data_final<-as.data.frame(lapply(gene_data_t, as.numeric))
  row.names(gene_data_final)<-sample_names
  gene_data_final[is.na(gene_data_final)] <- 0
  PC<-prcomp(gene_data_final)
  PCi<-data.frame(PC$x,time_point=paste(meta_data$Time,meta_data$Unit))
  #install.packages("ggplot2")
  library(ggplot2)
  PCAplot<-ggplot(PCi,aes(x=PC1,y=PC2,col=time_point))+
  geom_point(size=3,alpha=0.5)
  return(PCAplot)
  
}
