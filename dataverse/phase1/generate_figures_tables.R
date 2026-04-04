#################################################################
# Script to generate Figures and Tables in:
# Liberals Lecture, Conservatives Communicate:
# analyzing complexity and ideology in 381,609 speeches
# Martijn Schoonvelde, Anna Brosius, Gijs Schumacher, Bert Bakker
# Contact: mschoonvelde@gmail.com
#################################################################

###############
#load libraries
###############

rm(list=ls())
library(stringr)
library(stargazer)
library(ggplot2)
library(stringr)
library(merTools)
library(hrbrthemes)
library(devtools)
library(ggflags)
library(stringr)
library(plyr)

#load data

load("speeches.RData")

# Run regression analyses -------------------------------------------------
vars1 <- as.formula(scale(complexity) ~ scale(lr) + scale(pc) + year2 + office)

reg.output <- list()
reg.output[[1]] <- lm(vars1, data=speeches, subset=country=="DK" & data.set=="congress speeches")
reg.output[[2]] <- lm(vars1, data=speeches, subset=country=="NL" & data.set=="congress speeches")

reg.output[[3]] <- lm(vars1, data=speeches, subset=country=="Germany" & data.set=="parliamentary speeches")
reg.output[[4]] <- lm(vars1, data=speeches, subset=country=="Spain"  & data.set=="parliamentary speeches") 
reg.output[[5]] <- lm(vars1, data=speeches, subset=country=="UK" & data.set=="parliamentary speeches")
reg.output[[6]] <- lm(vars1, data=speeches, subset=country=="Sweden" & data.set=="parliamentary speeches")
reg.output[[7]] <-lm(vars1, data=speeches, subset=country=="Netherlands" & data.set=="parliamentary speeches") 

vars2 <- as.formula(scale(complexity) ~ scale(lr) + scale(pc))
reg.output[[8]] <- lm(vars2, data=speeches, subset=data.set=="PM speeches")

#figures progressive conservative (fig 2a)
####################################################

#create dataframe with model results to be plotted
coefs <- unlist(lapply(reg.output, function(x) x$coefficients[3]))
se <- unlist(lapply(reg.output, function(x) sqrt(diag(vcov(x)))[3]))
min <- coefs - 1.96*se
max <- coefs + 1.96*se
names <- c("Party congresses DNK", "Party congresses NLD", "Parliament GER", "Parliament ESP", "Parliament GBR", "Parliament SWE","Parliament NLD", "Heads of Government") 
plot.data <- data.frame(names,coefs,se,min,max)
order.names <- c(8,2,1,7,6,5,4,3)
plot.data <- plot.data[order.names,]
plot.data$names <- factor(plot.data$names, levels=plot.data$names)
plot.data$institution <- c(rep("Congress and Heads of Government","3"), rep("Parliament","5"))
plot.data$institution <- factor(plot.data$institution, levels = c("Parliament", "Congress and Heads of Government"))


#create plot
coef.plot2a <- ggplot(plot.data[], aes(x=names, y=coefs)) +
  geom_point(size = 1) +
  geom_errorbar(ymin=plot.data$min[],ymax=plot.data$max[], width=.1) +
  coord_flip() + 
  ylab("Effect of lib-cons ideology") +
  xlab("") + 
  geom_hline(yintercept=0) +
  theme_minimal() +
  facet_wrap(institution~., scales="free",nrow = 2) +  ylim(c(-.25,0.025)) + theme(panel.spacing = unit(2, "lines"))


ggsave(coef.plot2a, file="fig2a.eps"), dpi=300)

#figure left-right (fig 2b)
###############################

#create dataframe with model results to be plotted
coefs <- unlist(lapply(reg.output, function(x) x$coefficients[2]))
se <- unlist(lapply(reg.output, function(x) sqrt(diag(vcov(x)))[2]))
min <- coefs - 1.96*se
max <- coefs + 1.96*se
names <- c("Party congresses DNK", "Party congresses NLD", "Parliament GER", "Parliament ESP", "Parliament GBR", "Parliament SWE","Parliament NLD", "Heads of Government") 
plot.data <- data.frame(names,coefs,se,min,max)
order.names <- c(8,2,1,7,6,5,4,3)
plot.data <- plot.data[order.names,]
plot.data$names <- factor(plot.data$names, levels=plot.data$names)
plot.data$institution <- c(rep("Congress and Heads of Government","3"), rep("Parliament","5"))
plot.data$institution <- factor(plot.data$institution, levels = c("Parliament", "Congress and Heads of Government"))

#create plot
coef.plot2b <- ggplot(plot.data, aes(x=names, y=coefs)) +
  geom_point(size = 1) +
  geom_errorbar(ymin=plot.data$min,ymax=plot.data$max, width=.1) +
  coord_flip() + 
  ylab("Effect of left-right ideology") +
  xlab("") + 
  geom_hline(yintercept=0) +
  theme_minimal() +
  facet_wrap(institution~., scales="free",nrow = 2) +  ylim(c(-.20,0.11)) + theme(panel.spacing = unit(2, "lines"))

ggsave(coef.plot2b, file=paste0(getwd(),"fig2b.eps"), dpi=300)

#figure government - opposition (b1 appendix)
#############################################

#create dataframe with model results to be plotted
coefs <- unlist(lapply(reg.output, function(x) x$coefficients[5]))[-8]
se <- unlist(lapply(reg.output, function(x) sqrt(diag(vcov(x)))[5]))[-8]
min <- coefs - 1.96*se
max <- coefs + 1.96*se
names <- c("Party congresses DNK", "Party congresses NLD", "Parliament GER", "Parliament ESP", "Parliament GBR", "Parliament SWE","Parliament NLD")  
plot.data <- data.frame(names,coefs,se,min,max)
order.names <- c(2,1,7,6,5,4,3)
plot.data <- plot.data[order.names,]
plot.data$names <- factor(plot.data$names, levels=plot.data$names)
plot.data$institution <- c(rep("Congress","2"), rep("Parliament","5"))
plot.data$institution <- factor(plot.data$institution, levels = c("Parliament", "Congress"))

#create plot
coef.plotb1 <- ggplot(plot.data, aes(x=names, y=coefs)) +
  geom_point(size = 1) +
  geom_errorbar(ymin=plot.data$min,ymax=plot.data$max, width=.1) +
  coord_flip() + 
  ylab("Effect of government status") + geom_hline(yintercept=0) +
  xlab("") + facet_wrap(institution~., scales="free",nrow = 2) +
  theme_minimal() + theme(panel.spacing = unit(2, "lines")) +  ylim(c(-.075,0.30))

ggsave(coef.plotb1, file=paste0(getwd(),"figb1.eps"), dpi=300)

#figure time series complexity
#A: congress speeches
#B: parl speech
##############################
speeches.subset <- speeches[-which(speeches$data.set=="PM speeches"),]
speeches.subset$id <- ifelse(speeches.subset$country=="NL", "NLD",
                      ifelse(speeches.subset$country=="DK", "DNK",
                      ifelse(speeches.subset$country=="Germany", "GER",
                      ifelse(speeches.subset$country=="UK", "GBR",
                      ifelse(speeches.subset$country=="Netherlands", "NLD",
                      ifelse(speeches.subset$country=="Spain", "ESP",
                      ifelse(speeches.subset$country=="Sweden", "SWE",NA)))))))

speeches.subset$year <- as.numeric(speeches.subset$year)
speeches.subset$complexity[speeches.subset$country=="Spain"] <- speeches.subset$complexity[speeches.subset$country=="Spain"]-10
speeches.parl <- speeches.subset[speeches.subset$data.set=="parliamentary speeches",]  
speeches.congress <- speeches.subset[speeches.subset$data.set=="congress speeches",]  

time.plot.parl <- ggplot(speeches.parl,aes(x=year, y=complexity)) +
  geom_smooth(se=FALSE, colour="red") + 
  facet_wrap(~id, nrow=1) +
  scale_x_continuous(breaks=c(1990,2000,2010), labels=c("'90", "'00", "'10")) + 
  ylab("Complexity") +
  xlab("") + 
  theme_minimal() 

time.plot.congress <- ggplot(speeches.congress,aes(x=year, y=complexity)) +
  geom_smooth(se=FALSE, colour="red") + 
  facet_wrap(~id, nrow=1) +
  ylab("Complexity") +
  scale_x_continuous(breaks=c(1960,1980,2000), labels=c("'60", "'80", "'00")) + 
  xlab("") + 
  theme_minimal()  

ggsave(time.plot.parl, file=paste0(getwd(),"fig2c.eps"), dpi=300)
ggsave(time.plot.congress, file=paste0(getwd(),"fig2d.eps"), dpi=300)

## Fixed-effect models
vars3 <- as.formula(complexity ~ lr + pc + year2 + office + factor(speaker))
reg.output.fixed <- list()
reg.output.fixed[[1]]  <- lm(vars3, data=speeches, subset=country=="DK" & data.set=="congress speeches")
reg.output.fixed[[2]]  <- lm(vars3, data=speeches, subset=country=="NL" & data.set=="congress speeches")

reg.output.fixed[[3]] <- lm(vars3, data=speeches, subset=country=="Germany" & data.set=="parliamentary speeches")
reg.output.fixed[[4]] <- lm(vars3, data=speeches, subset=country=="Spain"  & data.set=="parliamentary speeches") 
reg.output.fixed[[5]] <- lm(vars3, data=speeches, subset=country=="UK" & data.set=="parliamentary speeches")
reg.output.fixed[[6]] <- lm(vars3, data=speeches, subset=country=="Sweden" & data.set=="parliamentary speeches")
reg.output.fixed[[7]] <-lm(vars3, data=speeches, subset=country=="Netherlands" & data.set=="parliamentary speeches") 

#plot data
##########

#create dataframe with model results to be plotted
coefs <- unlist(lapply(reg.output.fixed, function(x) coef(x)[3]))
se <- unlist(lapply(reg.output.fixed, function(x) sqrt(diag(vcov(x)))[3]))
min <- coefs - 1.96*se
max <- coefs + 1.96*se
names <- c("Party congresses DNK", "Party congresses NLD", "Parliament GER", "Parliament ESP", "Parliament GBR", "Parliament SWE","Parliament NLD") 
plot.data <- data.frame(names,coefs,se,min,max)
order.names <- c(2,1,7,6,5,4,3)
plot.data <- plot.data[order.names,]
plot.data$names <- factor(plot.data$names, levels=plot.data$names)

#create plot
coef.plot3 <- ggplot(plot.data, aes(x=names, y=coefs)) +
  geom_point() + 
  geom_errorbar(ymin=plot.data$min,ymax=plot.data$max, width=.1) +
  coord_flip() + 
  ylab("Fixed effect of conservatism") +
  xlab("") + 
  geom_hline(yintercept=0) +
  theme_minimal()


ggsave(coef.plot3, file=paste0(getwd(),"fig3a.eps"), dpi=900)

##################################################
#Write out regression and desc stats (see Appendix
##################################################

covariates <- c("Left-Right", "Progressive-Conservative", "Year", "In government")
descriptive.variables <- c("Complexity", "Left-Right", "Progressive-Conservative", "Year", "In government")

#first 4 OLS models
stargazer(reg.output[[1]],reg.output[[2]], reg.output[[3]],reg.output[[4]], covariate.labels=covariates, column.labels = c("DNK Congress", "NLD Congress", "GER Parl", "ESP Parl"), align=TRUE, single.row=FALSE, model.numbers = FALSE, font.size = "tiny", dep.var.caption="", dep.var.labels.include=FALSE, out="ols_regression_1.tex"))

#second 4 OLS models
stargazer(reg.output[[5]], reg.output[[6]], reg.output[[7]], reg.output[[8]], covariate.labels=covariates, column.labels = c("GBR Parl", "SWE Parl", "NLD Parl", "PM"), align=TRUE, single.row=FALSE, model.numbers = FALSE, font.size = "tiny", dep.var.caption="", dep.var.labels.include=FALSE, out= "ols_regression_2.tex"))

#first 4 fe models party
stargazer(reg.output.fixed[[1]],reg.output.fixed[[2]], reg.output.fixed[[3]],reg.output.fixed[[4]], add.lines=list(c("Party Fixed Effects?","Yes", "Yes", "Yes", "Yes")), omit = "speaker", covariate.labels=covariates, column.labels = c("DNK Congress", "NLD Congress", "GER Parl", "ESP Parl"), align=TRUE, single.row=FALSE, model.numbers = FALSE, font.size = "tiny", dep.var.caption="", dep.var.labels.include=FALSE, out="fe_regression_1.tex"))

#second 3 fe models party
stargazer(reg.output.fixed[[5]],reg.output.fixed[[6]], reg.output.fixed[[7]], covariate.labels=covariates, add.lines=list(c("Party Fixed Effects?","Yes", "Yes", "Yes")), omit = "speaker", column.labels = c("GBR Parl", "SWE Parl", "NLD Parl"), align=TRUE, single.row=FALSE, model.numbers = FALSE, font.size = "tiny", dep.var.caption="", dep.var.labels.include=FALSE, out="fe_regression_2.tex"))

#descriptive statistics
stargazer(reg.output[[1]]$model,reg.output[[2]]$model,reg.output[[3]]$model,reg.output[[4]]$model, reg.output[[5]]$model,reg.output[[6]]$model,reg.output[[7]]$model,reg.output[[8]]$model, covariate.labels=descriptive.variables, title=c(names[c(1:7)], "Heads of Government"), out = "descriptive_congress.tex"))


# #congress speech --------------------------------------------------------

load("congressspeech.Rdata")

congress.speech <-  speeches

# scale variables
congress.speech$scale.complexity <- scale(congress.speech$Flesch.Kincaid)
congress.speech$scale.pc<- scale(congress.speech$pc)

selection <- congress.speech[congress.speech$party=="S" | congress.speech$party=="VVD",]
selection$party <- factor(selection$party, labels=c("Social Democratic Party\n(DK)","Liberal Party\n(NL)"))

selection.plot <- ggplot(selection,aes(x=year, y=scale.complexity)) +
  geom_smooth(aes(colour="blue")) +
  geom_smooth(aes(x=selection$year, y=selection$scale.pc, colour="red")) +
  theme_minimal() +
  ylab("Standardized values") +
  xlab("") +
  facet_grid(party~., labeller = label_value) + 
  theme(legend.position="bottom") + scale_colour_manual(name="", values=c("blue", "red"), labels = c("complexity", "ideology")) 

ggsave(selection.plot, file="fig3b.eps", dpi=900)


# # EU Speech -------------------------------------------------------------
load("euspeech.Rdata")

eu.speech <-  speeches

example1 <- ddply(eu.speech, "speaker", summarise, 
              mean=mean(complexity, na.rm=TRUE), 
              SD=sd(complexity, na.rm=TRUE),
              N=length(speaker))
example1$se <- example1$SD / sqrt(example1$N)
example1$min <- example1$mean - 1.96*example1$se
example1$max <- example1$mean + 1.96*example1$se

example1 <- example1[c(4,6,8,10),] # select only cameron, brown, rajoy & zapatero
 
# Parlspeech
load("parlspeech.Rdata")

parl.speech <-  speeches[speeches$speaker%in%c("Nick Clegg","Wilders"," JIMMIE ÅKESSON ","Joseph Fischer"),]

example2 <- ddply(parl.speech, "speaker", summarise, 
                 mean=mean(flesh.grade, na.rm=TRUE), 
                 SD=sd(flesh, na.rm=TRUE),
                 N=length(speaker))
example2$se <- example2$SD / sqrt(example2$N)
example2$min <- example2$mean - 1.96*example2$se
example2$max <- example2$mean + 1.96*example2$se

example <- rbind(example1,example2)
example$speaker <- c("Cameron", "Brown", "Zapatero", "Rajoy", "Akesson", "Fischer", "Clegg", "Wilders")
example$prog <- c(0,1,1,0,0,1,1,0)
order <- c(5,8,7,6,4,3,1,2)
example <- example[order,]
example$speaker <- factor(example$speaker, levels=example$speaker)
example$country <- c("se","nl","gb", "de", "es", "es", "gb", "gb")

desc.plot <- ggplot(example, aes(x=speaker, y=mean, fill=factor(prog), country=country)) +
  geom_bar(stat="identity") + 
  geom_flag(y=17.5, x=seq(1,8,1), size=10) +
  geom_errorbar(ymin=example$min,ymax=example$max, width=.2) +
  coord_flip() +
  xlab("") +
  ylab("Mean Complexity") + 
  scale_fill_manual(values=c("#56B4E9","#E69F00")) + #"#999999", 
  theme_minimal() + 
  ylim(c(0,20)) + 
  guides(fill=FALSE)
  
ggsave(desc.plot, file="fig1.eps", dpi=900)
