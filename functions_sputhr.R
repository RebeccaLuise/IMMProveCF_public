# This script compiles functions used for the IMMPROVE_CF 16S data analysis, whcih were not embedded in packages
#Author: Rebecca L. Knoll, functions were mostly found on github or stackoverflow, links to the surce are incuded
#Date: 12.09.2022

#### find.top.taxa2 ####
#sourced from: https://github.com/joey711/phyloseq/issues/847


p <- ps_sputum_full

find.top.taxa2 <- function(x, taxa, num) {
  require(phyloseq)
  require(magrittr)
  
  top.taxa <- tax_glom(x, taxa)
  otu <-
    otu_table(top.taxa) # remove the transformation if using a merge_sample object
  tax <- tax_table(top.taxa)
  j1 <-
    apply(otu, 1, sort, index.return = T, decreasing = T) # modifying which.max to return a list of sorted index
  j2 <- lapply(j1, '[[', "ix") # select for index
  
  #k <- j[!duplicated(j)] # Replaced with unique() below
  l <- data.frame(unique(tax@.Data[unlist(j2),]))
  
  m <- data.frame(otu@.Data[, unique(unlist(j2))])
  #s <- as.name(taxa) # This isn't necessary!
  colnames(m) = l[, taxa]
  n <- apply(m, 1, sort, index.return = T, decreasing = T) %>%
    lapply('[[', "ix") %>% # Extract index
    lapply(head, n = num) # This to returns the top x tax
  
  p <- list()
  for (i in 1:length(n)) {
    p[[i]] <- colnames(m)[n[[i]]]
  }
  m$taxa <-
    p # replacing [,taxa], but now the new column is called "taxa" instead of the inputted taxonomic rank
  return(m)
}

#### end ####

#### find.top.asv ####
#sourced from: https://github.com/joey711/phyloseq/issues/847
find.top.asv <- function(x, num) {
  require(phyloseq)
  require(magrittr)
  
  otu <- otu_table(x)
  tax <- tax_table(x)
  j1 <-
    apply(otu, 1, sort, index.return = T, decreasing = T) # modifying which.max to return a list of sorted index
  j2 <- lapply(j1, '[[', "ix") # select for index
  
  l <- data.frame(unique(tax@.Data[unlist(j2),]))
  m <- data.frame(otu@.Data[, unique(unlist(j2))])
  n <- apply(m, 1, sort, index.return = T, decreasing = T) %>%
    lapply('[[', "ix") %>%  # Extract index
    lapply(head, n = num) # This to returns the top x tax
  
  p <- list()
  for (i in 1:length(n)) {
    p[[i]] <- colnames(m)[n[[i]]]
  }
  m$taxa <- p
  return(m)
}
#### end ####

count.genus <- function(x, num){
  require(phyloseq)
  require(magrittr)
  #x is a phyloseq object glomed to Genus
  #num is the threshold of Relative abundance desired 
  otu <- as(otu_table(x), "matrix")
  # transpose if necessary
  if(taxa_are_rows(x)){otu <- t(otu)}
  otu <- otu_table(otu, taxa_are_rows = F)
  tax <- tax_table(x)
  # Coerce to data.frame
  n <- as.data.frame(tax)
  n%>%
    rownames_to_column()%>%
    dplyr::rename(ASV = rowname)-> n
  
  j1 <- apply(otu,1,sort,index.return=T, decreasing=T) # modifying which.max to return a list of sorted index
  j2 <- lapply(j1,'[[',"x") # select for Names
  
  m <- data.frame(unlist(j2))
  
  m%>%
    rownames_to_column()%>%
    dplyr::filter(unlist.j2.!=0)%>%
    separate(rowname, c("SampleID", "ASV"))%>%
    dplyr::group_by(SampleID)%>%
    dplyr::rename(Abundance = unlist.j2.)%>%
    dplyr::mutate(Abundance = (Abundance/1E6)*100)%>%
    left_join(n, by="ASV")%>%
    #mutate(Main_taxa= Abundance>= num)%>%
    #dplyr::mutate(Type= case_when(Main_taxa== FALSE ~ "Satellites", TRUE ~ "Colonizers"))%>%
    arrange(SampleID, desc(Genus))->m
  
  m$Genus[is.na(m$Genus)]<- "Unassigned" ##Change NA's into Unassigned 
  m$Species<- NULL
  
  rm(otu, tax, j1, j2, n)
  return(m)
}

Rel.abund_fun <- function(df){
  df2 <- sapply(df, function(x) (x/1E6)*100)  
  colnames(df2) <- colnames(df)
  rownames(df2) <- rownames(df)
  df2<- as.data.frame(df2)
  return(df2)
}